import 'package:markdown_lite/markdown_lite.dart';

void main() {
  // Example markdown document
  final markdown = '''
# My Document

This is a paragraph with **bold** text and *italic* text.

## Features

- Supports headings
- Supports lists
- [Links](https://example.com)
- `inline code`
- ~~strikethrough~~

### Code Example

```dart
void main() {
  print('Hello, World!');
}
```

> This is a blockquote with important information.

### Task List

- [x] Completed task
- [ ] Pending task

1. First ordered item
2. Second ordered item
''';

  // Parse the markdown
  final nodes = parse(markdown);

  // Process the AST
  print('Parsed ${nodes.length} top-level nodes:\n');

  for (final node in nodes) {
    switch (node) {
      case H1Node():
        print('H1: ${node.text}');
      case H2Node():
        print('H2: ${node.text}');
      case H3Node():
        print('H3: ${node.text}');
      case ParagraphNode():
        print('Paragraph: ${node.text.substring(0, 50)}...');
      case UnorderedListNode():
        print('Unordered List with ${node.items.length} items');
        for (final item in node.items) {
          final checkbox = item.isChecked != null
              ? (item.isChecked! ? '[x]' : '[ ]')
              : '';
          print('  - $checkbox ${item.text}');
        }
      case OrderedListNode():
        print('Ordered List with ${node.items.length} items');
        for (var i = 0; i < node.items.length; i++) {
          print('  ${i + 1}. ${node.items[i].text}');
        }
      case CodeBlockNode():
        print('Code Block (${node.language ?? 'no language'}):');
        print('  ${node.text}');
      case BlockquoteNode():
        print('Blockquote: ${node.text}');
      case HeadingNode():
        print('H${node.level}: ${node.text}');
      case _:
        print('Other node: ${node.runtimeType}');
    }
  }
}
