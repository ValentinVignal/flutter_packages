import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class _Titles {
  const _Titles({this.shortTitle, this.longTitle, required this.host});
  final String? shortTitle;
  final String? longTitle;
  final String host;
}

@internal
class LinkPreview extends StatefulWidget {
  const LinkPreview({super.key, required this.url, this.textStyle});

  final Uri url;

  final TextStyle? textStyle;

  @override
  State<LinkPreview> createState() => _LinkPreviewState();
}

class _LinkPreviewState extends State<LinkPreview> {
  late Future<_Titles?> _titlesFuture;

  // Extract content="..." from a meta tag that matches any of the provided (name|property) keys.
  String? _extractMetaContent(String html, List<String> keys) {
    for (final key in keys) {
      final re = RegExp(
        r"""<meta[^>]+(?:name|property)\s*=\s*["']""" +
            RegExp.escape(key) +
            r"""["'][^>]*content\s*=\s*["']([^"']+)["']""",
        caseSensitive: false,
      );
      final m = re.firstMatch(html);
      if (m != null) return m.group(1)?.trim();
    }
    return null;
  }

  String? _extractTitleTag(String html) {
    final m = RegExp(
      r'<title[^>]*>\s*([^<]+)\s*</title>',
      caseSensitive: false,
    ).firstMatch(html);
    return m?.group(1)?.trim();
  }

  // Get both short and long titles. Avoids extra packages.
  Future<_Titles?> _fetchTitles() async {
    // On web, cross-origin fetches are blocked by CORS. Fall back to domain.
    if (kIsWeb) {
      final host = widget.url.host.isNotEmpty
          ? widget.url.host
          : widget.url.toString();
      return _Titles(host: host);
    }

    try {
      final resp = await http
          .get(
            widget.url,
            headers: {
              // Some sites require a common UA to return full HTML.
              'User-Agent':
                  'Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 '
                  '(KHTML, like Gecko) Chrome/114.0 Safari/537.36',
              'Accept':
                  'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8',
            },
          )
          .timeout(const Duration(seconds: 5));

      if (resp.statusCode != 200 || resp.body.isEmpty) {
        final host = widget.url.host.isNotEmpty
            ? widget.url.host
            : widget.url.toString();
        return _Titles(host: host);
      }

      // Work on the first chunk to be fast (most meta are in the head).
      final html = resp.body.length > 200000
          ? resp.body.substring(0, 200000)
          : resp.body;

      // Long title preference: og:title -> twitter:title -> <title> -> host
      final ogTitle = _extractMetaContent(html, ['og:title']);
      final twTitle = _extractMetaContent(html, ['twitter:title']);
      final titleTag = _extractTitleTag(html);

      // Short title preference: og:site_name -> application-name -> apple-mobile-web-app-title -> host
      final siteName = _extractMetaContent(html, ['og:site_name']);
      final appName = _extractMetaContent(html, ['application-name']);
      final appleTitle = _extractMetaContent(html, [
        'apple-mobile-web-app-title',
      ]);

      final host = widget.url.host.isNotEmpty
          ? widget.url.host
          : widget.url.toString();
      final longTitle = (ogTitle ?? twTitle ?? titleTag ?? host).trim();
      final shortTitle = (siteName ?? appName ?? appleTitle ?? host).trim();

      return _Titles(shortTitle: shortTitle, longTitle: longTitle, host: host);
    } catch (_) {
      final host = widget.url.host.isNotEmpty
          ? widget.url.host
          : widget.url.toString();
      return _Titles(host: host);
    }
  }

  @override
  void initState() {
    super.initState();

    _titlesFuture = _fetchTitles();
  }

  @override
  void didUpdateWidget(covariant LinkPreview oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.url != widget.url) {
      _titlesFuture = _fetchTitles();
    }
  }

  Future<void> _copyToClipboard() async {
    await Clipboard.setData(ClipboardData(text: widget.url.toString()));
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('URL copied to clipboard')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double size = (widget.textStyle?.fontSize ?? 16);
    final faviconUrl =
        'https://www.google.com/s2/favicons?sz=64&domain_url=${widget.url}';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          launchUrl(widget.url);
        },
        onSecondaryTap: _copyToClipboard,
        onLongPress: _copyToClipboard,
        child: FutureBuilder<_Titles?>(
          future: _titlesFuture,
          builder: (context, snapshot) {
            final tooltipMessages = <String>[
              ?snapshot.data?.shortTitle,
              ?snapshot.data?.longTitle,
            ];

            final String tooltipText;
            if (tooltipMessages.isEmpty) {
              tooltipText = snapshot.data?.host ?? '';
            } else {
              tooltipText = tooltipMessages.whereType<String>().join(': ');
            }
            return Tooltip(
              message: tooltipText,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.network(
                      faviconUrl,
                      width: size * 0.9,
                      height: size * 0.9,
                      errorBuilder: (context, error, stackTrace) {
                        // On error, render a generic link icon to keep layout stable.
                        return Icon(Icons.link, size: size);
                      },
                    ),
                    Builder(
                      builder: (context) {
                        if (snapshot.data?.shortTitle?.isNotEmpty ?? false) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 2),
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: size * 6),
                              child: Text(
                                snapshot.data!.shortTitle!,
                                style: (widget.textStyle ?? const TextStyle())
                                    .copyWith(
                                      fontSize: size * 0.7,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0,
                                      wordSpacing: 0,
                                    ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          );
                        }
                        // While loading or if no title, show nothing extra
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
