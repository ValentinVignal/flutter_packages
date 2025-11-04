import 'ast_node.dart';

/// Returns a human-readable, multi-line string representation of the AST.
///
/// - [nodes]: The root nodes to render.
/// - [indent]: Indentation string used per depth level (default two spaces).
/// - [showRaw]: If true, also includes each node's `rawText` where helpful.
/// - [textMax]: Maximum number of characters to show for text previews.
String prettyPrintAst(
  List<AstNode> nodes, {
  String indent = '  ',
  bool showRaw = false,
  int textMax = 80,
}) {
  final buf = StringBuffer();
  for (final node in nodes) {
    _writeNode(buf, node, 0, indent, showRaw, textMax);
  }
  return buf.toString();
}

/// Prints a human-readable AST to stdout.
void printAst(
  List<AstNode> nodes, {
  String indent = '  ',
  bool showRaw = false,
  int textMax = 80,
}) {
  // ignore: avoid_print
  print(
    prettyPrintAst(nodes, indent: indent, showRaw: showRaw, textMax: textMax),
  );
}

void _writeNode(
  StringBuffer buf,
  AstNode node,
  int depth,
  String indent,
  bool showRaw,
  int textMax,
) {
  final prefix = _repeat(indent, depth);
  buf.writeln('$prefix${_nodeLabel(node, showRaw: showRaw, textMax: textMax)}');

  switch (node) {
    case ParagraphNode(children: final children):
      for (final child in children) {
        _writeNode(buf, child, depth + 1, indent, showRaw, textMax);
      }
      return;
    case UnorderedListNode(items: final items):
      for (final item in items) {
        _writeNode(buf, item, depth + 1, indent, showRaw, textMax);
      }
      return;
    case OrderedListNode(items: final items):
      for (final item in items) {
        _writeNode(buf, item, depth + 1, indent, showRaw, textMax);
      }
      return;
    case ListItemNode(children: final children):
      for (final child in children) {
        _writeNode(buf, child, depth + 1, indent, showRaw, textMax);
      }
      return;
    case BlockquoteNode(children: final children):
      for (final child in children) {
        _writeNode(buf, child, depth + 1, indent, showRaw, textMax);
      }
      return;
    case BlankLineNode():
      return;
    default:
      return;
  }
}

String _nodeLabel(AstNode node, {required bool showRaw, required int textMax}) {
  String t(String s) => _trimPreview(s, textMax);

  switch (node) {
    // Headings
    case H1Node():
      return 'H1: "${t(node.text)}"';
    case H2Node():
      return 'H2: "${t(node.text)}"';
    case H3Node():
      return 'H3: "${t(node.text)}"';
    case H4Node():
      return 'H4: "${t(node.text)}"';
    case H5Node():
      return 'H5: "${t(node.text)}"';
    case H6Node():
      return 'H6: "${t(node.text)}"';

    // Blocks
    case ParagraphNode():
      return _withRaw('Paragraph: "${t(node.text)}"', node, showRaw);
    case UnorderedListNode():
      return _withRaw('UnorderedList', node, showRaw);
    case OrderedListNode():
      return _withRaw('OrderedList', node, showRaw);
    case ListItemNode(isChecked: final c):
      final checkbox = c == null ? '' : (c ? ' [x]' : ' [ ]');
      return _withRaw('ListItem$checkbox: "${t(node.text)}"', node, showRaw);
    case CodeBlockNode(language: final lang):
      final langStr = lang ?? '-';
      return _withRaw(
        'CodeBlock(lang: $langStr): "${t(node.text)}"',
        node,
        showRaw,
      );
    case BlockquoteNode():
      return _withRaw('Blockquote', node, showRaw);

    // Inline
    case BoldNode():
      return _withRaw('Bold: "${t(node.text)}"', node, showRaw);
    case ItalicNode():
      return _withRaw('Italic: "${t(node.text)}"', node, showRaw);
    case StrikethroughNode():
      return _withRaw('Strikethrough: "${t(node.text)}"', node, showRaw);
    case InlineCodeNode():
      return _withRaw('InlineCode: "${t(node.text)}"', node, showRaw);
    case LinkNode(url: final url):
      return _withRaw('Link: text="${t(node.text)}" url="$url"', node, showRaw);
    case TextNode():
      return _withRaw('Text: "${t(node.text)}"', node, showRaw);
    case BlankLineNode():
      return 'BlankLine';
  }
}

String _withRaw(String head, AstNode node, bool showRaw) {
  if (!showRaw) return head;
  if (node.rawText.isEmpty) return head;
  final raw = _escapeMultiline(node.rawText);
  return '$head (raw: "$raw")';
}

String _trimPreview(String s, int max) {
  final esc = _escapeMultiline(s);
  if (esc.length <= max) return esc;
  return '${esc.substring(0, max - 1)}…';
}

String _escapeMultiline(String s) => s.replaceAll('\n', r"\n");

String _repeat(String s, int times) => List.filled(times, s).join();
