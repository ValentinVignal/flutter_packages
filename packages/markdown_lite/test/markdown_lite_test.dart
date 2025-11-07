import 'package:markdown_lite/markdown_lite.dart';
import 'package:test/test.dart';

void main() {
  group('Headings', () {
    test('parses H1 heading', () {
      final nodes = parse('# Hello World');
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<H1Node>());
      final heading = nodes[0] as H1Node;
      expect(heading.text, equals('Hello World'));
      expect(heading.rawText, equals('# Hello World'));
      expect(heading.level, equals(1));
    });

    test('parses H2 heading', () {
      final nodes = parse('## Subtitle');
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<H2Node>());
      final heading = nodes[0] as H2Node;
      expect(heading.text, equals('Subtitle'));
      expect(heading.rawText, equals('## Subtitle'));
      expect(heading.level, equals(2));
    });

    test('parses H3 heading', () {
      final nodes = parse('### Section');
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<H3Node>());
      final heading = nodes[0] as H3Node;
      expect(heading.level, equals(3));
    });

    test('parses H4 heading', () {
      final nodes = parse('#### Subsection');
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<H4Node>());
      final heading = nodes[0] as H4Node;
      expect(heading.level, equals(4));
    });

    test('parses H5 heading', () {
      final nodes = parse('##### Small heading');
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<H5Node>());
      final heading = nodes[0] as H5Node;
      expect(heading.level, equals(5));
    });

    test('parses H6 heading', () {
      final nodes = parse('###### Smallest heading');
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<H6Node>());
      final heading = nodes[0] as H6Node;
      expect(heading.level, equals(6));
    });

    test('parses multiple headings', () {
      final markdown = '''# Title
## Subtitle
### Section''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(3));
      expect(nodes[0], isA<H1Node>());
      expect(nodes[1], isA<H2Node>());
      expect(nodes[2], isA<H3Node>());
    });
  });

  group('Paragraphs', () {
    test('parses simple paragraph', () {
      final nodes = parse('This is a simple paragraph.');
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<ParagraphNode>());
      final paragraph = nodes[0] as ParagraphNode;
      expect(paragraph.text, equals('This is a simple paragraph.'));
      expect(paragraph.rawText, equals('This is a simple paragraph.'));
    });

    test('parses multi-line paragraph', () {
      final markdown = '''This is a paragraph
that spans multiple lines.''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<ParagraphNode>());
      final paragraph = nodes[0] as ParagraphNode;
      expect(paragraph.text, contains('multiple lines'));
    });

    test('parses multiple paragraphs', () {
      final markdown = '''First paragraph.

Second paragraph.''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(2));
      expect(nodes[0], isA<ParagraphNode>());
      expect(nodes[1], isA<ParagraphNode>());
    });
  });

  group('Inline Styles', () {
    test('parses bold text with **', () {
      final nodes = parse('This is **bold** text.');
      expect(nodes, hasLength(1));
      final paragraph = nodes[0] as ParagraphNode;
      expect(paragraph.children, isNotEmpty);

      final boldNode = paragraph.children.whereType<BoldNode>().firstOrNull;
      expect(boldNode, isNotNull);
      expect(boldNode!.text, equals('bold'));
      expect(boldNode.rawText, equals('**bold**'));
    });

    test('parses bold text with __', () {
      final nodes = parse('This is __bold__ text.');
      expect(nodes, hasLength(1));
      final paragraph = nodes[0] as ParagraphNode;

      final boldNode = paragraph.children.whereType<BoldNode>().firstOrNull;
      expect(boldNode, isNotNull);
      expect(boldNode!.text, equals('bold'));
      expect(boldNode.rawText, equals('__bold__'));
    });

    test('parses italic text with *', () {
      final nodes = parse('This is *italic* text.');
      expect(nodes, hasLength(1));
      final paragraph = nodes[0] as ParagraphNode;

      final italicNode = paragraph.children.whereType<ItalicNode>().firstOrNull;
      expect(italicNode, isNotNull);
      expect(italicNode!.text, equals('italic'));
      expect(italicNode.rawText, equals('*italic*'));
    });

    test('parses italic text with _', () {
      final nodes = parse('This is _italic_ text.');
      expect(nodes, hasLength(1));
      final paragraph = nodes[0] as ParagraphNode;

      final italicNode = paragraph.children.whereType<ItalicNode>().firstOrNull;
      expect(italicNode, isNotNull);
      expect(italicNode!.text, equals('italic'));
      expect(italicNode.rawText, equals('_italic_'));
    });

    test('parses strikethrough text', () {
      final nodes = parse('This is ~~strikethrough~~ text.');
      expect(nodes, hasLength(1));
      final paragraph = nodes[0] as ParagraphNode;

      final strikeNode = paragraph.children
          .whereType<StrikethroughNode>()
          .firstOrNull;
      expect(strikeNode, isNotNull);
      expect(strikeNode!.text, equals('strikethrough'));
      expect(strikeNode.rawText, equals('~~strikethrough~~'));
    });

    test('parses inline code', () {
      final nodes = parse('Use `print()` to output text.');
      expect(nodes, hasLength(1));
      final paragraph = nodes[0] as ParagraphNode;

      final codeNode = paragraph.children
          .whereType<InlineCodeNode>()
          .firstOrNull;
      expect(codeNode, isNotNull);
      expect(codeNode!.text, equals('print()'));
      expect(codeNode.rawText, equals('`print()`'));
    });

    test('parses multiple inline styles', () {
      final nodes = parse('Text with **bold**, *italic*, and `code`.');
      expect(nodes, hasLength(1));
      final paragraph = nodes[0] as ParagraphNode;

      expect(paragraph.children.whereType<BoldNode>(), hasLength(1));
      expect(paragraph.children.whereType<ItalicNode>(), hasLength(1));
      expect(paragraph.children.whereType<InlineCodeNode>(), hasLength(1));
    });
  });

  group('Links', () {
    test('parses simple link', () {
      final nodes = parse('Visit [Google](https://google.com) now.');
      expect(nodes, hasLength(1));
      final paragraph = nodes[0] as ParagraphNode;

      final linkNode = paragraph.children.whereType<LinkNode>().firstOrNull;
      expect(linkNode, isNotNull);
      expect(linkNode!.text, equals('Google'));
      expect(linkNode.url, equals('https://google.com'));
      expect(linkNode.rawText, equals('[Google](https://google.com)'));
    });

    test('parses multiple links', () {
      final nodes = parse('[Link 1](url1) and [Link 2](url2)');
      expect(nodes, hasLength(1));
      final paragraph = nodes[0] as ParagraphNode;

      final linkNodes = paragraph.children.whereType<LinkNode>().toList();
      expect(linkNodes, hasLength(2));
      expect(linkNodes[0].text, equals('Link 1'));
      expect(linkNodes[0].url, equals('url1'));
      expect(linkNodes[1].text, equals('Link 2'));
      expect(linkNodes[1].url, equals('url2'));
    });
  });

  group('Lists', () {
    test('parses unordered list with -', () {
      final markdown = '''- Item 1
- Item 2
- Item 3''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<UnorderedListNode>());

      final list = nodes[0] as UnorderedListNode;
      expect(list.items, hasLength(3));
      expect(list.items[0].text, equals('Item 1'));
      expect(list.items[1].text, equals('Item 2'));
      expect(list.items[2].text, equals('Item 3'));
      expect(list.items[0].isChecked, isNull);
    });

    test('parses unordered list with *', () {
      final markdown = '''* First
* Second''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<UnorderedListNode>());

      final list = nodes[0] as UnorderedListNode;
      expect(list.items, hasLength(2));
    });

    test('parses unordered list with +', () {
      final markdown = '''+ Alpha
+ Beta''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<UnorderedListNode>());

      final list = nodes[0] as UnorderedListNode;
      expect(list.items, hasLength(2));
    });

    test('parses ordered list', () {
      final markdown = '''1. First item
2. Second item
3. Third item''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<OrderedListNode>());

      final list = nodes[0] as OrderedListNode;
      expect(list.items, hasLength(3));
      expect(list.items[0].text, equals('First item'));
      expect(list.items[1].text, equals('Second item'));
      expect(list.items[2].text, equals('Third item'));
    });

    test('parses list items with inline formatting', () {
      final markdown = '''- **Bold** item
- *Italic* item
- `Code` item''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(1));

      final list = nodes[0] as UnorderedListNode;
      expect(list.items, hasLength(3));
      expect(list.items[0].children.whereType<BoldNode>(), hasLength(1));
      expect(list.items[1].children.whereType<ItalicNode>(), hasLength(1));
      expect(list.items[2].children.whereType<InlineCodeNode>(), hasLength(1));
    });
  });

  group('Checkboxes', () {
    test('parses unchecked checkbox in unordered list', () {
      final markdown = '''- [ ] Unchecked item
- [x] Checked item''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(1));

      final list = nodes[0] as UnorderedListNode;
      expect(list.items, hasLength(2));
      expect(list.items[0].text, equals('Unchecked item'));
      expect(list.items[0].isChecked, equals(false));
      expect(list.items[1].text, equals('Checked item'));
      expect(list.items[1].isChecked, equals(true));
    });

    test('parses checked checkbox with X', () {
      final markdown = '- [X] Checked with capital X';
      final nodes = parse(markdown);

      final list = nodes[0] as UnorderedListNode;
      expect(list.items[0].isChecked, equals(true));
    });

    test('parses checkboxes in ordered list', () {
      final markdown = '''1. [ ] Task 1
2. [x] Task 2''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(1));

      final list = nodes[0] as OrderedListNode;
      expect(list.items, hasLength(2));
      expect(list.items[0].isChecked, equals(false));
      expect(list.items[1].isChecked, equals(true));
    });
  });

  group('Code Blocks', () {
    test('parses code block without language', () {
      final markdown = '''```
var x = 10;
print(x);
```''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<CodeBlockNode>());

      final codeBlock = nodes[0] as CodeBlockNode;
      expect(codeBlock.text, equals('var x = 10;\nprint(x);'));
      expect(codeBlock.language, isNull);
    });

    test('parses code block with language', () {
      final markdown = '''```dart
void main() {
  print('Hello');
}
```''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(1));

      final codeBlock = nodes[0] as CodeBlockNode;
      expect(codeBlock.text, contains('void main()'));
      expect(codeBlock.language, equals('dart'));
    });

    test('parses code block with different language', () {
      final markdown = '''```javascript
console.log("Hello");
```''';
      final nodes = parse(markdown);

      final codeBlock = nodes[0] as CodeBlockNode;
      expect(codeBlock.language, equals('javascript'));
    });

    test('unterminated code fence does not consume following lines', () {
      final markdown = '''```dart
void main() {
  print('Hello');
''';
      final nodes = parse(markdown);
      expect(nodes.length, greaterThanOrEqualTo(2));

      // First node is the unterminated fence marker
      expect(nodes.first, isA<CodeBlockNode>());
      final codeBlock = nodes.first as CodeBlockNode;
      expect(codeBlock.language, equals('dart'));
      expect(codeBlock.text, equals(''));
      expect(codeBlock.isTerminated, isFalse);

      // Next content should be parsed normally (e.g., as a paragraph)
      expect(
        nodes[1],
        anyOf([isA<ParagraphNode>(), isA<H1Node>(), isA<TextNode>()]),
      );
    });

    test('parses lone opening fence as empty code block at EOF', () {
      final markdown = '```\n';
      final nodes = parse(markdown);
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<CodeBlockNode>());

      final codeBlock = nodes[0] as CodeBlockNode;
      expect(codeBlock.text, equals(''));
      expect(codeBlock.language, isNull);
      expect(codeBlock.isTerminated, isFalse);
    });
  });

  group('Blockquotes', () {
    test('parses simple blockquote', () {
      final markdown = '> This is a quote';
      final nodes = parse(markdown);
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<BlockquoteNode>());

      final blockquote = nodes[0] as BlockquoteNode;
      expect(blockquote.text, equals('This is a quote'));
      expect(blockquote.rawText, equals('> This is a quote'));
    });

    test('parses multi-line blockquote', () {
      final markdown = '''>First line
>Second line''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(1));

      final blockquote = nodes[0] as BlockquoteNode;
      expect(blockquote.text, contains('First line'));
      expect(blockquote.text, contains('Second line'));
    });

    test('parses blockquote with nested content', () {
      final markdown = '''> # Heading in quote
> This is text''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(1));

      final blockquote = nodes[0] as BlockquoteNode;
      expect(blockquote.children, isNotEmpty);
      expect(blockquote.children[0], isA<H1Node>());
    });
  });

  group('Complex Documents', () {
    test('parses mixed content', () {
      final markdown = '''# Title

This is a paragraph with **bold** and *italic* text.

## Section

- Item 1
- Item 2

```dart
void main() {}
```

> A quote''';
      final nodes = parse(markdown);

      expect(nodes.whereType<H1Node>(), hasLength(1));
      expect(nodes.whereType<H2Node>(), hasLength(1));
      expect(nodes.whereType<ParagraphNode>(), hasLength(1));
      expect(nodes.whereType<UnorderedListNode>(), hasLength(1));
      expect(nodes.whereType<CodeBlockNode>(), hasLength(1));
      expect(nodes.whereType<BlockquoteNode>(), hasLength(1));
    });

    test('parses empty string', () {
      final nodes = parse('');
      expect(nodes, isEmpty);
    });

    test('parses string with only whitespace', () {
      final nodes = parse('   \n\n   ');
      expect(nodes, isEmpty);
    });

    test('handles content with multiple blank lines', () {
      final markdown = '''# Title


Paragraph after blank lines''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(2));
      expect(nodes[0], isA<H1Node>());
      expect(nodes[1], isA<ParagraphNode>());
    });
  });

  group('Edge Cases', () {
    test('handles text without markdown syntax', () {
      final nodes = parse('Plain text without any markdown.');
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<ParagraphNode>());
    });

    test('handles heading without space after hash', () {
      final nodes = parse('#NoSpace');
      // Should be treated as paragraph since there's no space
      expect(nodes, hasLength(1));
      expect(nodes[0], isA<ParagraphNode>());
    });

    test('handles list item with link', () {
      final markdown = '- Visit [Google](https://google.com)';
      final nodes = parse(markdown);

      final list = nodes[0] as UnorderedListNode;
      final linkNode = list.items[0].children.whereType<LinkNode>().firstOrNull;
      expect(linkNode, isNotNull);
      expect(linkNode!.text, equals('Google'));
    });

    test('parses consecutive different list types', () {
      final markdown = '''- Unordered

1. Ordered''';
      final nodes = parse(markdown);
      expect(nodes, hasLength(2));
      expect(nodes[0], isA<UnorderedListNode>());
      expect(nodes[1], isA<OrderedListNode>());
    });
  });
}
