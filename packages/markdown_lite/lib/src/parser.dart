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

    // Precompile regexes
    final reCode = RegExp(r'`([^`]+)`');
    final reLink = RegExp(r'\[([^\]]+)\]\(([^)]+)\)');
    final reBold = RegExp(r'(\*\*|__)([^\*_]+)\1');
    final reStrike = RegExp(r'~~([^~]+)~~');
    final reItalic = RegExp(r'(\*|_)([^\*_]+)\1');

    while (currentPos < text.length) {
      Match? best;
      _InlineTokenKind? kind;
      int bestAbsStart = text.length + 1;

      void consider(RegExp re, _InlineTokenKind k) {
        final m = re.firstMatch(text.substring(currentPos));
        if (m == null) return;
        final absStart = currentPos + m.start;
        if (absStart < bestAbsStart) {
          bestAbsStart = absStart;
          best = m;
          kind = k;
        }
      }

      // Consider all token types; priority when tied is the order considered
      // (code > link > bold > strike > italic) which avoids some ambiguities.
      consider(reCode, _InlineTokenKind.code);
      consider(reLink, _InlineTokenKind.link);
      consider(reBold, _InlineTokenKind.bold);
      consider(reStrike, _InlineTokenKind.strike);
      consider(reItalic, _InlineTokenKind.italic);

      if (best == null) {
        // No more tokens; remaining text is plain
        if (currentPos < text.length) {
          final plain = text.substring(currentPos);
          nodes.add(TextNode(text: plain, rawText: plain));
        }
        break;
      }

      // Emit preceding plain text if any
      if (bestAbsStart > currentPos) {
        final plain = text.substring(currentPos, bestAbsStart);
        if (plain.isNotEmpty) {
          nodes.add(TextNode(text: plain, rawText: plain));
        }
        currentPos = bestAbsStart;
      }

      // Emit the matched token
      final raw = best!.group(0)!;
      switch (kind!) {
        case _InlineTokenKind.code:
          // Inline code doesn't support nested formatting
          nodes.add(InlineCodeNode(text: best!.group(1)!, rawText: raw));
        case _InlineTokenKind.link:
          // Recursively parse link text for nested formatting
          final linkText = best!.group(1)!;
          final url = best!.group(2)!;
          final linkChildren = _parseInlineContent(linkText);
          nodes.add(
            LinkNode(
              text: linkText,
              rawText: raw,
              url: url,
              children: linkChildren,
            ),
          );
        case _InlineTokenKind.bold:
          // Recursively parse bold content for nested formatting
          final boldText = best!.group(2)!;
          final boldChildren = _parseInlineContent(boldText);
          nodes.add(
            BoldNode(text: boldText, rawText: raw, children: boldChildren),
          );
        case _InlineTokenKind.strike:
          // Recursively parse strikethrough content for nested formatting
          final strikeText = best!.group(1)!;
          final strikeChildren = _parseInlineContent(strikeText);
          nodes.add(
            StrikethroughNode(
              text: strikeText,
              rawText: raw,
              children: strikeChildren,
            ),
          );
        case _InlineTokenKind.italic:
          // Recursively parse italic content for nested formatting
          final italicText = best!.group(2)!;
          final italicChildren = _parseInlineContent(italicText);
          nodes.add(
            ItalicNode(
              text: italicText,
              rawText: raw,
              children: italicChildren,
            ),
          );
      }
      currentPos = bestAbsStart + raw.length;
    }

    return nodes;
  }
}
