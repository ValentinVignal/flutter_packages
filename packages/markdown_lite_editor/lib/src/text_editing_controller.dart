import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown_lite/markdown_lite.dart' as md;

class MarkdownTextEditingController extends TextEditingController {
  MarkdownTextEditingController({super.text});

  TextStyle _baseStyle(BuildContext context, TextStyle? style) {
    // Fallback to DefaultTextStyle if incoming style is null.
    return style ?? DefaultTextStyle.of(context).style;
  }

  TextStyle? _headingStyle(BuildContext context, int level) {
    return switch (level) {
      1 => Theme.of(context).textTheme.headlineLarge,
      2 => Theme.of(context).textTheme.headlineMedium,
      3 => Theme.of(context).textTheme.headlineSmall,
      4 => Theme.of(context).textTheme.titleLarge,
      5 => Theme.of(context).textTheme.titleMedium,
      6 => Theme.of(context).textTheme.titleSmall,
      _ => null,
    };
  }

  TextStyle _bold(TextStyle base) =>
      base.merge(const TextStyle(fontWeight: FontWeight.bold));
  TextStyle _italic(TextStyle base) =>
      base.merge(const TextStyle(fontStyle: FontStyle.italic));
  TextStyle _strike(TextStyle base) =>
      base.merge(const TextStyle(decoration: TextDecoration.lineThrough));
  TextStyle _inlineCode(BuildContext context, TextStyle base) {
    final theme = Theme.of(context);
    return base.merge(
      GoogleFonts.inconsolata(
        backgroundColor: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.6,
        ),
      ),
    );
  }

  TextStyle _codeBlock(BuildContext context, TextStyle base) {
    return _inlineCode(context, base);
  }

  TextStyle _linkStyle(BuildContext context, TextStyle base) {
    final theme = Theme.of(context);
    return base.merge(
      TextStyle(
        color: theme.colorScheme.primary,
        decoration: TextDecoration.underline,
      ),
    );
  }

  TextStyle _blockquoteStyle(BuildContext context, TextStyle base) {
    final theme = Theme.of(context);
    return base.merge(
      TextStyle(
        color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.8),
        backgroundColor: theme.colorScheme.surfaceContainer.withValues(
          alpha: 0.6,
        ),
      ),
    );
  }

  // Syntax character styles (Discord-like)
  TextStyle _syntaxStyle(BuildContext context) {
    final theme = Theme.of(context);
    return TextStyle(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
      fontSize: 14,
    );
  }

  TextStyle _headingSyntaxStyle(BuildContext context) {
    final theme = Theme.of(context);
    return TextStyle(
      color: theme.colorScheme.primary.withValues(alpha: 0.6),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle _linkSyntaxStyle(BuildContext context) {
    final theme = Theme.of(context);
    return TextStyle(color: theme.colorScheme.primary.withValues(alpha: 0.5));
  }

  TextStyle _linkUrlStyle(BuildContext context) {
    final theme = Theme.of(context);
    return TextStyle(color: theme.colorScheme.primary.withValues(alpha: 0.7));
  }

  TextStyle _codeBlockLanguageStyle(BuildContext context) {
    final theme = Theme.of(context);
    return GoogleFonts.inconsolata(
      color: theme.colorScheme.tertiary,
      fontSize: 12,
    );
  }

  TextStyle _listMarkerStyle(BuildContext context) {
    final theme = Theme.of(context);
    return TextStyle(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle _checkboxUncheckedStyle(BuildContext context) {
    final theme = Theme.of(context);
    return TextStyle(
      color: theme.colorScheme.primary,
      fontWeight: FontWeight.w600,
      background: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = theme.colorScheme.primary,
    );
  }

  TextStyle _checkboxCheckedStyle(BuildContext context) {
    final theme = Theme.of(context);
    return TextStyle(
      color: theme.colorScheme.onPrimary,
      backgroundColor: theme.colorScheme.primary,
      fontWeight: FontWeight.bold,
      // Filled background to make the checkbox stand out
    );
  }

  TextStyle _blockquoteSyntaxStyle(BuildContext context) {
    final theme = Theme.of(context);
    return TextStyle(
      color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
    );
  }

  // Build TextSpans for a full markdown document.
  List<InlineSpan> _buildDocumentSpans(
    BuildContext context,
    TextStyle base,
    List<md.AstNode> nodes,
  ) {
    final spans = <InlineSpan>[];
    for (var i = 0; i < nodes.length; i++) {
      final node = nodes[i];
      // Insert one newline between non-blank nodes to reflect original line breaks.
      if (i > 0 && node is! md.BlankLineNode) {
        spans.add(TextSpan(text: '\n', style: base));
      }
      spans.addAll(_visitNode(context, base, node));
    }
    return spans;
  }

  // Helper that visits a node and applies additional styling on top of base
  // This version shows syntax characters with different styling (Discord-style)
  List<InlineSpan> _visitNodeWithStyle(
    BuildContext context,
    TextStyle base,
    md.AstNode node,
  ) {
    switch (node) {
      // Bold: show ** or __ with syntax style
      case md.BoldNode(:final children, :final delimiter):
        final spans = <InlineSpan>[];
        final boldStyle = _bold(base);
        final syntaxStyle = _syntaxStyle(context);

        // Opening delimiter
        spans.add(TextSpan(text: delimiter, style: syntaxStyle));

        // Content
        if (children.isEmpty) {
          spans.add(TextSpan(text: node.text, style: boldStyle));
        } else {
          for (final child in children) {
            spans.addAll(_visitNodeWithStyle(context, boldStyle, child));
          }
        }

        // Closing delimiter
        spans.add(TextSpan(text: delimiter, style: syntaxStyle));
        return spans;

      // Italic: show * or _ with syntax style
      case md.ItalicNode(:final children, :final delimiter):
        final spans = <InlineSpan>[];
        final italicStyle = _italic(base);
        final syntaxStyle = _syntaxStyle(context);

        spans.add(TextSpan(text: delimiter, style: syntaxStyle));
        if (children.isEmpty) {
          spans.add(TextSpan(text: node.text, style: italicStyle));
        } else {
          for (final child in children) {
            spans.addAll(_visitNodeWithStyle(context, italicStyle, child));
          }
        }
        spans.add(TextSpan(text: delimiter, style: syntaxStyle));
        return spans;

      // Strikethrough: show ~~ with syntax style
      case md.StrikethroughNode(:final children, :final delimiter):
        final spans = <InlineSpan>[];
        final strikeStyle = _strike(base);
        final syntaxStyle = _syntaxStyle(context);

        spans.add(TextSpan(text: delimiter, style: syntaxStyle));
        if (children.isEmpty) {
          spans.add(TextSpan(text: node.text, style: strikeStyle));
        } else {
          for (final child in children) {
            spans.addAll(_visitNodeWithStyle(context, strikeStyle, child));
          }
        }
        spans.add(TextSpan(text: delimiter, style: syntaxStyle));
        return spans;

      // Inline code: show ` with syntax style
      case md.InlineCodeNode(:final delimiter):
        final spans = <InlineSpan>[];
        final syntaxStyle = _syntaxStyle(context);
        final codeStyle = _inlineCode(context, base);

        spans.add(TextSpan(text: delimiter, style: syntaxStyle));
        spans.add(TextSpan(text: node.text, style: codeStyle));
        spans.add(TextSpan(text: delimiter, style: syntaxStyle));
        return spans;

      // Link: show [] and () with different styles for markdown links
      // For auto-links, just show the URL with link styling
      case md.LinkNode(:final children, :final url, :final isAutoLink):
        final spans = <InlineSpan>[];
        final linkTextStyle = _linkStyle(context, base);

        if (isAutoLink) {
          // Auto-link: just show the text as-is with link styling
          if (children.isEmpty) {
            spans.add(TextSpan(text: node.text, style: linkTextStyle));
          } else {
            for (final child in children) {
              spans.addAll(_visitNodeWithStyle(context, linkTextStyle, child));
            }
          }
        } else {
          // Markdown link: show [text](url) with syntax characters
          final linkSyntaxStyle = _linkSyntaxStyle(context);
          final urlStyle = _linkUrlStyle(context);

          // [
          spans.add(TextSpan(text: '[', style: linkSyntaxStyle));

          // link text
          if (children.isEmpty) {
            spans.add(TextSpan(text: node.text, style: linkTextStyle));
          } else {
            for (final child in children) {
              spans.addAll(_visitNodeWithStyle(context, linkTextStyle, child));
            }
          }

          // ](
          spans.add(TextSpan(text: ']', style: linkSyntaxStyle));
          spans.add(TextSpan(text: '(', style: linkSyntaxStyle));

          // URL
          spans.add(TextSpan(text: url, style: urlStyle));

          // )
          spans.add(TextSpan(text: ')', style: linkSyntaxStyle));
        }

        return spans;

      case md.TextNode():
        return [TextSpan(text: node.text, style: base)];

      default:
        // For any other node type, use regular visitNode
        return _visitNode(context, base, node);
    }
  }

  // Build spans for list items with proper indentation for nesting
  // Shows syntax characters with different styling
  List<InlineSpan> _buildListSpans(
    BuildContext context,
    TextStyle base,
    List<md.ListItemNode> items,
    bool isOrdered,
  ) {
    final spans = <InlineSpan>[];
    final markerStyle = _listMarkerStyle(context);

    for (final item in items) {
      // Add indentation based on indent level
      if (item.indentLevel > 0) {
        spans.add(TextSpan(text: '  ' * item.indentLevel, style: base));
      }

      // Preserve exact number of spaces typed after the marker without duplicating
      final trimmedRaw = item.rawText.trimLeft();
      // Capture the exact spaces typed after the marker. Previous pattern mistakenly used 's*' (literal 's').
      final markerSpaceMatch = RegExp(
        '^${RegExp.escape(item.marker)}(\\s*)',
      ).firstMatch(trimmedRaw);
      final originalSpace = markerSpaceMatch?.group(1) ?? '';

      // Count leading spaces that will appear in the rendered children (from item.text)
      final leadingSpacesInText =
          item.text.length - item.text.trimLeft().length;
      // For items with content (item.text not empty), we already render leadingSpacesInText inside children.
      // So only render the difference to avoid duplication. For empty items, render all original spaces.
      final spacesToRender = item.text.isEmpty
          ? originalSpace.length
          : (originalSpace.length - leadingSpacesInText).clamp(
              0,
              originalSpace.length,
            );

      // Render marker itself
      spans.add(TextSpan(text: item.marker, style: markerStyle));
      // Render preserved spaces (if any)
      if (spacesToRender > 0) {
        spans.add(TextSpan(text: ' ' * spacesToRender, style: base));
      }

      // Add checkbox if present with styled brackets and fill
      if (item.isChecked != null) {
        // Reconstruct the original bracket form and any space that followed it
        final trimmedRaw = item.rawText.trimLeft();
        final rawMatch = RegExp(
          r'^[-*+]\s+(\[[xX ]?\])(\s*)',
        ).firstMatch(trimmedRaw);
        String rawBracket = item.isChecked! ? '[x]' : '[ ]';
        String spaceAfter = ' ';
        if (rawMatch != null) {
          rawBracket = rawMatch.group(1)!; // preserves [] vs [ ] vs [x]
          spaceAfter = rawMatch.group(2)!; // may be empty or multiple spaces
        }
        if (item.isChecked!) {
          final checkedStyle = _checkboxCheckedStyle(context);
          spans.add(TextSpan(text: rawBracket, style: checkedStyle));
        } else {
          final uncheckedStyle = _checkboxUncheckedStyle(context);
          spans.add(TextSpan(text: rawBracket, style: uncheckedStyle));
        }
        if (spaceAfter.isNotEmpty) {
          spans.add(TextSpan(text: spaceAfter, style: base));
        }
      }

      // Add the item content with inline styling
      for (final child in item.children) {
        spans.addAll(_visitNodeWithStyle(context, base, child));
      }

      // Add nested list if present
      if (item.nestedList != null) {
        spans.add(TextSpan(text: '\n', style: base));
        final nestedItems = item.nestedList!.items;
        final nestedIsOrdered = item.nestedList is md.OrderedListNode;
        spans.addAll(
          _buildListSpans(context, base, nestedItems, nestedIsOrdered),
        );
      }

      // Add newline after each item (except possibly the last)
      if (item != items.last || item.nestedList != null) {
        spans.add(TextSpan(text: '\n', style: base));
      }
    }

    return spans;
  }

  // Visitor that returns a list of spans for the given node.
  List<InlineSpan> _visitNode(
    BuildContext context,
    TextStyle base,
    md.AstNode node,
  ) {
    switch (node) {
      // Headings: show # with syntax style
      case md.HeadingNode():
        final heading = node;
        final level = heading.level;
        final headingTextStyle = _headingStyle(context, level) ?? base;
        final syntaxStyle = _headingSyntaxStyle(context);

        final spans = <InlineSpan>[];
        // Show the # prefix
        spans.add(TextSpan(text: '${heading.prefix} ', style: syntaxStyle));

        // Show the heading content
        for (final child in heading.children) {
          spans.addAll(_visitNodeWithStyle(context, headingTextStyle, child));
        }

        return spans;

      // Paragraphs: show content with nested children
      case md.ParagraphNode(:final children):
        final spans = <InlineSpan>[];
        for (final child in children) {
          spans.addAll(_visitNodeWithStyle(context, base, child));
        }
        return spans;

      // Unordered list: render each item with proper indentation
      case md.UnorderedListNode(:final items):
        return _buildListSpans(context, base, items, false);

      // Ordered list: render each item with proper indentation
      case md.OrderedListNode(:final items):
        return _buildListSpans(context, base, items, true);

      // List item: process inline children
      case md.ListItemNode(:final children):
        final spans = <InlineSpan>[];
        for (final child in children) {
          spans.addAll(_visitNodeWithStyle(context, base, child));
        }
        return spans;

      // Code block: show ``` with syntax style and language. If unterminated, do not render closing fence.
      case md.CodeBlockNode(:final language, :final isTerminated):
        final spans = <InlineSpan>[];
        final syntaxStyle = _syntaxStyle(context);
        final codeStyle = _codeBlock(context, base);
        final langStyle = _codeBlockLanguageStyle(context);

        // Opening ``` (and optional language)
        spans.add(TextSpan(text: '```', style: syntaxStyle));
        if (language != null && language.isNotEmpty) {
          spans.add(TextSpan(text: language, style: langStyle));
        }
        if (node.text.isNotEmpty) {
          spans.add(TextSpan(text: '\n', style: base));
        }

        // Code content
        spans.add(TextSpan(text: node.text, style: codeStyle));

        // Closing ``` only if the block was terminated and we rendered content
        if (isTerminated) {
          final needsLeadingNewline = node.text.isNotEmpty;
          spans.add(
            TextSpan(
              text: needsLeadingNewline ? '\n```' : '```',
              style: syntaxStyle,
            ),
          );
        }
        return spans;

      // Blank line
      case md.BlankLineNode():
        return [TextSpan(text: '\n', style: base)];

      // Blockquote: parse rawText which already includes >
      case md.BlockquoteNode(:final rawText):
        final spans = <InlineSpan>[];
        final qStyle = _blockquoteStyle(context, base);
        final syntaxStyle = _blockquoteSyntaxStyle(context);

        // Parse rawText line by line, styling > separately
        final lines = rawText.split('\n');
        for (var i = 0; i < lines.length; i++) {
          final line = lines[i].trimLeft();

          if (line.startsWith('>')) {
            // Add the > with syntax style
            final leadingSpaces = lines[i].length - lines[i].trimLeft().length;
            if (leadingSpaces > 0) {
              spans.add(TextSpan(text: ' ' * leadingSpaces, style: base));
            }
            spans.add(TextSpan(text: '> ', style: syntaxStyle));

            // Get the content after >
            final content = line.substring(1).trimLeft();
            if (content.isNotEmpty) {
              // Parse inline content for styling
              final contentNodes = md.parse(content);
              for (final contentNode in contentNodes) {
                spans.addAll(_visitNodeWithStyle(context, qStyle, contentNode));
              }
            }
          }

          // Add newline if not last line
          if (i < lines.length - 1) {
            spans.add(TextSpan(text: '\n', style: base));
          }
        }

        return spans;

      // Inline styles: delegate to _visitNodeWithStyle
      case md.BoldNode():
      case md.ItalicNode():
      case md.StrikethroughNode():
      case md.InlineCodeNode():
      case md.LinkNode():
        return _visitNodeWithStyle(context, base, node);

      // Plain text
      case md.TextNode():
        return [TextSpan(text: node.text, style: base)];
    }
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final base = _baseStyle(context, style);

    // Parse markdown into AST using markdown_lite.
    final nodes = md.parse(text);

    // Build styled spans for entire document.
    final children = _buildDocumentSpans(context, base, nodes);

    return TextSpan(style: base, children: children);
  }
}
