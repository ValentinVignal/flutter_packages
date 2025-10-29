# markdown_lite

A simple, lightweight package that parses markdown text into an Abstract Syntax Tree (AST).

## Features

This package provides a markdown parser that converts markdown text into a structured AST with type-safe nodes. Each node contains both the parsed text (without markdown annotations) and the original raw text (with markdown annotations).

## Supported Markdown Elements

- [x] Headings (H1-H6)
- [x] Paragraphs
- [x] Bold, italic and strike-through text
- [x] Lists (ordered and unordered)
- [x] Code blocks
- [x] Links
- [x] Inline code
- [x] Blockquotes
- [x] Checkboxes

## Usage

````dart
import 'package:markdown_lite/markdown_lite.dart';

void main() {
  final markdown = '''
# Title

This is a paragraph with **bold** and *italic* text.

- Item 1
- [x] Checked item
- [ ] Unchecked item

```dart
void main() {
  print('Code block');
}
\```

> This is a blockquote
''';

  final nodes = parse(markdown);

  for (final node in nodes) {
    switch (node) {
      case H1Node():
        print('Heading 1: ${node.text}');
      case ParagraphNode():
        print('Paragraph: ${node.text}');
      case UnorderedListNode():
        for (final item in node.items) {
          print('- ${item.text}');
        }
      case CodeBlockNode():
        print('Code (${node.language}): ${node.text}');
      case BlockquoteNode():
        print('Quote: ${node.text}');
      default:
        print('Other: ${node.runtimeType}');
    }
  }
}
````

## AST Node Types

The parser uses sealed classes for type-safe pattern matching:

### Block Nodes

- `H1Node`, `H2Node`, `H3Node`, `H4Node`, `H5Node`, `H6Node` - Heading nodes with level 1-6
- `ParagraphNode` - Paragraph containing inline content
- `UnorderedListNode` - Unordered list (bullet points)
- `OrderedListNode` - Ordered list (numbered)
- `CodeBlockNode` - Code block with optional language
- `BlockquoteNode` - Blockquote containing nested content

### Inline Nodes

- `BoldNode` - Bold text (\*\*text\*\* or \_\_text\_\_)
- `ItalicNode` - Italic text (\*text\* or \_text\_)
- `StrikethroughNode` - Strikethrough text (\~\~text\~\~)
- `InlineCodeNode` - Inline code (\`code\`)
- `LinkNode` - Link with text and URL
- `TextNode` - Plain text without formatting

### Special Nodes

- `ListItemNode` - List item with optional checkbox state
  - `isChecked` property is `null` for regular items, `true` for checked, `false` for unchecked

## Node Properties

Every node has:

- `text` - The parsed text without markdown annotations (e.g., "Title" for "# Title")
- `rawText` - The original text with markdown annotations (e.g., "# Title")

Additional properties:

- `HeadingNode.level` - Heading level (1-6)
- `CodeBlockNode.language` - Optional language identifier
- `LinkNode.url` - URL target
- `ListItemNode.isChecked` - Checkbox state (null, true, or false)
- Container nodes have `children` or `items` properties for nested content

## Example

See the [example](example/markdown_lite_example.dart) for a complete demonstration.
