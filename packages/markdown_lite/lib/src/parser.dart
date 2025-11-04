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

    final node = switch (level) {
      1 => H1Node(text: text, rawText: line),
      2 => H2Node(text: text, rawText: line),
      3 => H3Node(text: text, rawText: line),
      4 => H4Node(text: text, rawText: line),
      5 => H5Node(text: text, rawText: line),
      6 => H6Node(text: text, rawText: line),
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
      var matched = false;

      // Try to match inline code first (highest priority to avoid conflicts)
      final inlineCodeMatch = RegExp(
        r'`([^`]+)`',
      ).firstMatch(text.substring(currentPos));
      if (inlineCodeMatch != null && inlineCodeMatch.start == 0) {
        if (currentPos > 0 && nodes.isEmpty) {
          // Add any preceding text
          final precedingText = text.substring(0, currentPos);
          if (precedingText.isNotEmpty) {
            nodes.add(TextNode(text: precedingText, rawText: precedingText));
          }
        }

        final rawText = inlineCodeMatch.group(0)!;
        final codeText = inlineCodeMatch.group(1)!;
        nodes.add(InlineCodeNode(text: codeText, rawText: rawText));
        currentPos += rawText.length;
        matched = true;
        continue;
      }

      // Try to match links
      final linkMatch = RegExp(
        r'\[([^\]]+)\]\(([^)]+)\)',
      ).firstMatch(text.substring(currentPos));
      if (linkMatch != null && linkMatch.start == 0) {
        final rawText = linkMatch.group(0)!;
        final linkText = linkMatch.group(1)!;
        final url = linkMatch.group(2)!;
        nodes.add(LinkNode(text: linkText, rawText: rawText, url: url));
        currentPos += rawText.length;
        matched = true;
        continue;
      }

      // Try to match bold (** or __)
      final boldMatch = RegExp(
        r'(\*\*|__)([^\*_]+)\1',
      ).firstMatch(text.substring(currentPos));
      if (boldMatch != null && boldMatch.start == 0) {
        final rawText = boldMatch.group(0)!;
        final boldText = boldMatch.group(2)!;
        nodes.add(BoldNode(text: boldText, rawText: rawText));
        currentPos += rawText.length;
        matched = true;
        continue;
      }

      // Try to match strikethrough (~~)
      final strikeMatch = RegExp(
        r'~~([^~]+)~~',
      ).firstMatch(text.substring(currentPos));
      if (strikeMatch != null && strikeMatch.start == 0) {
        final rawText = strikeMatch.group(0)!;
        final strikeText = strikeMatch.group(1)!;
        nodes.add(StrikethroughNode(text: strikeText, rawText: rawText));
        currentPos += rawText.length;
        matched = true;
        continue;
      }

      // Try to match italic (* or _)
      final italicMatch = RegExp(
        r'(\*|_)([^\*_]+)\1',
      ).firstMatch(text.substring(currentPos));
      if (italicMatch != null && italicMatch.start == 0) {
        final rawText = italicMatch.group(0)!;
        final italicText = italicMatch.group(2)!;
        nodes.add(ItalicNode(text: italicText, rawText: rawText));
        currentPos += rawText.length;
        matched = true;
        continue;
      }

      // If no match, consume one character as plain text
      if (!matched) {
        currentPos++;
      }
    }

    // If we have accumulated plain text at the end, add it
    if (nodes.isEmpty && text.isNotEmpty) {
      nodes.add(TextNode(text: text, rawText: text));
    }

    return nodes;
  }
}
