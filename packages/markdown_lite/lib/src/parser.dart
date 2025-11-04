import 'ast_node.dart';

/// Parses a markdown string and returns a list of AST nodes.
///
/// Supports:
/// - Headings (H1-H6)
/// - Paragraphs
/// - Bold, italic, and strikethrough text
/// - Lists (ordered and unordered)
/// - Code blocks
/// - Links
/// - Inline code
/// - Blockquotes
/// - Checkboxes
List<AstNode> parse(String markdownString) {
  final parser = _MarkdownParser(markdownString);
  return parser.parse();
}

enum _InlineTokenKind { code, link, bold, strike, italic }

class _MarkdownParser {
  const _MarkdownParser(this.input);

  final String input;

  List<AstNode> parse() {
    final List<AstNode> nodes = [];
    final lines = input.split('\n');
    var i = 0;

    while (i < lines.length) {
      final line = lines[i];

      // Skip empty lines
      if (line.trim().isEmpty) {
        nodes.add(const BlankLineNode());
        i++;
        continue;
      }

      // Check for code blocks
      if (line.trim().startsWith('```')) {
        final result = _parseCodeBlock(lines, i);
        if (result != null) {
          nodes.add(result.$1);
          i = result.$2;
          continue;
        }
      }

      // Check for blockquotes
      if (line.trimLeft().startsWith('>')) {
        final result = _parseBlockquote(lines, i);
        nodes.add(result.$1);
        i = result.$2;
        continue;
      }

      // Check for headings
      final headingNode = _parseHeading(line);
      if (headingNode != null) {
        nodes.add(headingNode);
        i++;
        continue;
      }

      // Check for unordered lists
      if (_isUnorderedListItem(line)) {
        final result = _parseUnorderedList(lines, i);
        nodes.add(result.$1);
        i = result.$2;
        continue;
      }

      // Check for ordered lists
      if (_isOrderedListItem(line)) {
        final result = _parseOrderedList(lines, i);
        nodes.add(result.$1);
        i = result.$2;
        continue;
      }

      // Default to paragraph
      final result = _parseParagraph(lines, i);
      nodes.add(result.$1);
      i = result.$2;
    }

    return nodes;
  }

  AstNode? _parseHeading(String line) {
    final trimmed = line.trimLeft();

    // Match headings
    final match = RegExp(r'^(#{1,6})\s+(.+)$').firstMatch(trimmed);
    if (match == null) return null;

    final hashes = match.group(1)!;
    final text = match.group(2)!;
    final level = hashes.length;
    final children = _parseInlineContent(text);

    final node = switch (level) {
      1 => H1Node(text: text, rawText: line, children: children),
      2 => H2Node(text: text, rawText: line, children: children),
      3 => H3Node(text: text, rawText: line, children: children),
      4 => H4Node(text: text, rawText: line, children: children),
      5 => H5Node(text: text, rawText: line, children: children),
      6 => H6Node(text: text, rawText: line, children: children),
      _ => null,
    };

    return node;
  }

  (CodeBlockNode, int)? _parseCodeBlock(List<String> lines, int startIndex) {
    final firstLine = lines[startIndex];
    final match = RegExp(r'^```(\w*)').firstMatch(firstLine.trim());
    if (match == null) return null;

    final language = match.group(1);
    final codeLines = <String>[];
    var i = startIndex + 1;

    // Find the closing ```
    while (i < lines.length) {
      if (lines[i].trim().startsWith('```')) {
        // Build the raw text
        final rawText = lines.sublist(startIndex, i + 1).join('\n');
        final text = codeLines.join('\n');

        return (
          CodeBlockNode(
            text: text,
            rawText: rawText,
            language: language?.isEmpty ?? true ? null : language,
          ),
          i + 1,
        );
      }
      codeLines.add(lines[i]);
      i++;
    }

    // No closing found, treat as paragraph
    return null;
  }

  (BlockquoteNode, int) _parseBlockquote(List<String> lines, int startIndex) {
    final blockquoteLines = <String>[];
    var i = startIndex;

    while (i < lines.length && lines[i].trimLeft().startsWith('>')) {
      final line = lines[i].trimLeft();
      // Remove the '>' and optional space after it
      final content = line.substring(1).trimLeft();
      blockquoteLines.add(content);
      i++;
    }

    final text = blockquoteLines.join('\n');
    final rawLines = lines.sublist(startIndex, i);
    final rawText = rawLines.join('\n');

    // Parse children recursively
    final children = blockquoteLines.isEmpty
        ? <AstNode>[]
        : _MarkdownParser(blockquoteLines.join('\n')).parse();

    return (
      BlockquoteNode(text: text, rawText: rawText, children: children),
      i,
    );
  }

  bool _isUnorderedListItem(String line) {
    final trimmed = line.trimLeft();
    return RegExp(r'^[-*+]\s').hasMatch(trimmed);
  }

  bool _isOrderedListItem(String line) {
    final trimmed = line.trimLeft();
    return RegExp(r'^\d+\.\s').hasMatch(trimmed);
  }

  (UnorderedListNode, int) _parseUnorderedList(
    List<String> lines,
    int startIndex,
  ) {
    final items = <ListItemNode>[];
    var i = startIndex;

    while (i < lines.length && _isUnorderedListItem(lines[i])) {
      final line = lines[i];
      final trimmed = line.trimLeft();

      // Check for checkbox
      final checkboxMatch = RegExp(
        r'^[-*+]\s+\[([ xX])\]\s+(.+)$',
      ).firstMatch(trimmed);

      if (checkboxMatch != null) {
        final checked = checkboxMatch.group(1)!.toLowerCase() == 'x';
        final text = checkboxMatch.group(2)!;
        final children = _parseInlineContent(text);

        items.add(
          ListItemNode(
            text: text,
            rawText: line,
            children: children,
            isChecked: checked,
          ),
        );
      } else {
        final match = RegExp(r'^[-*+]\s+(.+)$').firstMatch(trimmed);
        if (match != null) {
          final text = match.group(1)!;
          final children = _parseInlineContent(text);

          items.add(
            ListItemNode(text: text, rawText: line, children: children),
          );
        }
      }

      i++;
    }

    final rawLines = lines.sublist(startIndex, i);
    final rawText = rawLines.join('\n');
    final text = items.map((item) => item.text).join('\n');

    return (UnorderedListNode(text: text, rawText: rawText, items: items), i);
  }

  (OrderedListNode, int) _parseOrderedList(List<String> lines, int startIndex) {
    final items = <ListItemNode>[];
    var i = startIndex;

    while (i < lines.length && _isOrderedListItem(lines[i])) {
      final line = lines[i];
      final trimmed = line.trimLeft();

      // Check for checkbox
      final checkboxMatch = RegExp(
        r'^\d+\.\s+\[([ xX])\]\s+(.+)$',
      ).firstMatch(trimmed);

      if (checkboxMatch != null) {
        final checked = checkboxMatch.group(1)!.toLowerCase() == 'x';
        final text = checkboxMatch.group(2)!;
        final children = _parseInlineContent(text);

        items.add(
          ListItemNode(
            text: text,
            rawText: line,
            children: children,
            isChecked: checked,
          ),
        );
      } else {
        final match = RegExp(r'^\d+\.\s+(.+)$').firstMatch(trimmed);
        if (match != null) {
          final text = match.group(1)!;
          final children = _parseInlineContent(text);

          items.add(
            ListItemNode(text: text, rawText: line, children: children),
          );
        }
      }

      i++;
    }

    final rawLines = lines.sublist(startIndex, i);
    final rawText = rawLines.join('\n');
    final text = items.map((item) => item.text).join('\n');

    return (OrderedListNode(text: text, rawText: rawText, items: items), i);
  }

  (ParagraphNode, int) _parseParagraph(List<String> lines, int startIndex) {
    final paragraphLines = <String>[];
    var i = startIndex;

    while (i < lines.length) {
      final line = lines[i];

      // Stop at empty lines
      if (line.trim().isEmpty) break;

      // Stop at special syntax
      if (_isUnorderedListItem(line) ||
          _isOrderedListItem(line) ||
          line.trimLeft().startsWith('>') ||
          line.trim().startsWith('```') ||
          _parseHeading(line) != null) {
        break;
      }

      paragraphLines.add(line);
      i++;
    }

    final text = paragraphLines.join('\n');
    final children = _parseInlineContent(text);

    return (ParagraphNode(text: text, rawText: text, children: children), i);
  }

  List<AstNode> _parseInlineContent(String text) {
    final nodes = <AstNode>[];
    var currentPos = 0;

    while (currentPos < text.length) {
      // Try to find the next inline token in priority order
      int? tokenStart;
      _InlineTokenKind? tokenKind;
      int tokenEnd = -1;
      String? tokenContent;
      String? linkUrl;

      // Helper to find matching delimiter
      int? findClosing(String openDelim, String closeDelim, int startPos) {
        var pos = startPos;
        while (pos < text.length) {
          final idx = text.indexOf(closeDelim, pos);
          if (idx == -1) return null;
          // Make sure we're not inside a code block
          final beforeCode = text.substring(startPos, idx);
          if (!beforeCode.contains('`')) return idx;
          // Skip past this potential match
          pos = idx + closeDelim.length;
        }
        return null;
      }

      // 1. Check for inline code (highest priority, no nesting)
      final codeStart = text.indexOf('`', currentPos);
      if (codeStart != -1) {
        final codeEnd = text.indexOf('`', codeStart + 1);
        if (codeEnd != -1) {
          tokenStart = codeStart;
          tokenKind = _InlineTokenKind.code;
          tokenEnd = codeEnd + 1;
          tokenContent = text.substring(codeStart + 1, codeEnd);
        }
      }

      // 2. Check for links
      if (tokenStart == null || (tokenStart > currentPos)) {
        final linkStart = text.indexOf('[', currentPos);
        if (linkStart != -1 && (tokenStart == null || linkStart < tokenStart)) {
          final linkTextEnd = text.indexOf(']', linkStart + 1);
          if (linkTextEnd != -1 &&
              linkTextEnd + 1 < text.length &&
              text[linkTextEnd + 1] == '(') {
            final linkUrlEnd = text.indexOf(')', linkTextEnd + 2);
            if (linkUrlEnd != -1) {
              tokenStart = linkStart;
              tokenKind = _InlineTokenKind.link;
              tokenEnd = linkUrlEnd + 1;
              tokenContent = text.substring(linkStart + 1, linkTextEnd);
              linkUrl = text.substring(linkTextEnd + 2, linkUrlEnd);
            }
          }
        }
      }

      // 3. Check for bold (**text** or __text__)
      if (tokenStart == null || (tokenStart > currentPos)) {
        for (final delim in ['**', '__']) {
          final boldStart = text.indexOf(delim, currentPos);
          if (boldStart != -1 &&
              (tokenStart == null || boldStart < tokenStart)) {
            final boldEnd = findClosing(delim, delim, boldStart + delim.length);
            if (boldEnd != null && boldEnd > boldStart + delim.length) {
              tokenStart = boldStart;
              tokenKind = _InlineTokenKind.bold;
              tokenEnd = boldEnd + delim.length;
              tokenContent = text.substring(boldStart + delim.length, boldEnd);
              break;
            }
          }
        }
      }

      // 4. Check for strikethrough
      if (tokenStart == null || (tokenStart > currentPos)) {
        final strikeStart = text.indexOf('~~', currentPos);
        if (strikeStart != -1 &&
            (tokenStart == null || strikeStart < tokenStart)) {
          final strikeEnd = text.indexOf('~~', strikeStart + 2);
          if (strikeEnd != -1 && strikeEnd > strikeStart + 2) {
            tokenStart = strikeStart;
            tokenKind = _InlineTokenKind.strike;
            tokenEnd = strikeEnd + 2;
            tokenContent = text.substring(strikeStart + 2, strikeEnd);
          }
        }
      }

      // 5. Check for italic (*text* or _text_) - must be careful not to match ** or __
      if (tokenStart == null || (tokenStart > currentPos)) {
        for (final delim in ['*', '_']) {
          final italicStart = text.indexOf(delim, currentPos);
          if (italicStart != -1 &&
              (tokenStart == null || italicStart < tokenStart)) {
            // Make sure it's not part of ** or __
            if (italicStart > 0 && text[italicStart - 1] == delim) continue;
            if (italicStart + 1 < text.length && text[italicStart + 1] == delim)
              continue;

            final italicEnd = findClosing(delim, delim, italicStart + 1);
            if (italicEnd != null && italicEnd > italicStart + 1) {
              // Make sure closing is not part of ** or __
              if (italicEnd + 1 < text.length && text[italicEnd + 1] == delim)
                continue;

              tokenStart = italicStart;
              tokenKind = _InlineTokenKind.italic;
              tokenEnd = italicEnd + 1;
              tokenContent = text.substring(italicStart + 1, italicEnd);
              break;
            }
          }
        }
      }

      // If no token found, emit remaining text as plain
      if (tokenStart == null) {
        if (currentPos < text.length) {
          final plain = text.substring(currentPos);
          nodes.add(TextNode(text: plain, rawText: plain));
        }
        break;
      }

      // Emit plain text before the token
      if (tokenStart > currentPos) {
        final plain = text.substring(currentPos, tokenStart);
        nodes.add(TextNode(text: plain, rawText: plain));
      }

      // Emit the token
      final raw = text.substring(tokenStart, tokenEnd);
      switch (tokenKind!) {
        case _InlineTokenKind.code:
          nodes.add(InlineCodeNode(text: tokenContent!, rawText: raw));
        case _InlineTokenKind.link:
          final linkChildren = _parseInlineContent(tokenContent!);
          nodes.add(
            LinkNode(
              text: tokenContent,
              rawText: raw,
              url: linkUrl!,
              children: linkChildren,
            ),
          );
        case _InlineTokenKind.bold:
          final boldChildren = _parseInlineContent(tokenContent!);
          nodes.add(
            BoldNode(text: tokenContent, rawText: raw, children: boldChildren),
          );
        case _InlineTokenKind.strike:
          final strikeChildren = _parseInlineContent(tokenContent!);
          nodes.add(
            StrikethroughNode(
              text: tokenContent,
              rawText: raw,
              children: strikeChildren,
            ),
          );
        case _InlineTokenKind.italic:
          final italicChildren = _parseInlineContent(tokenContent!);
          nodes.add(
            ItalicNode(
              text: tokenContent,
              rawText: raw,
              children: italicChildren,
            ),
          );
      }

      currentPos = tokenEnd;
    }

    return nodes;
  }
}
