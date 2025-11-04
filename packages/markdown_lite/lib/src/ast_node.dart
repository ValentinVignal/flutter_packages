/// Base class for all AST nodes in the markdown parser.
///
/// Each node contains:
/// - [text]: The parsed text without markdown annotations
/// - [rawText]: The original text with markdown annotations
sealed class AstNode {
  const AstNode({required this.text, required this.rawText});

  /// The parsed text without markdown annotations.
  ///
  /// For example, for `## Title`, this would be `Title`.
  final String text;

  /// The original text including markdown annotations.
  ///
  /// For example, for `## Title`, this would be `## Title`.
  final String rawText;
}

/// Represents a heading node (H1-H6).
sealed class HeadingNode extends AstNode {
  const HeadingNode({
    required super.text,
    required super.rawText,
    this.children = const [],
  });

  /// The level of the heading (1-6).
  int get level;

  /// Inline nodes within the heading (bold, italic, links, etc.).
  final List<AstNode> children;
}

/// Represents an H1 heading.
final class H1Node extends HeadingNode {
  const H1Node({required super.text, required super.rawText, super.children});

  @override
  int get level => 1;
}

/// Represents an H2 heading.
final class H2Node extends HeadingNode {
  const H2Node({required super.text, required super.rawText, super.children});

  @override
  int get level => 2;
}

/// Represents an H3 heading.
final class H3Node extends HeadingNode {
  const H3Node({required super.text, required super.rawText, super.children});

  @override
  int get level => 3;
}

/// Represents an H4 heading.
final class H4Node extends HeadingNode {
  const H4Node({required super.text, required super.rawText, super.children});

  @override
  int get level => 4;
}

/// Represents an H5 heading.
final class H5Node extends HeadingNode {
  const H5Node({required super.text, required super.rawText, super.children});

  @override
  int get level => 5;
}

/// Represents an H6 heading.
final class H6Node extends HeadingNode {
  const H6Node({required super.text, required super.rawText, super.children});

  @override
  int get level => 6;
}

/// Represents a paragraph node.
final class ParagraphNode extends AstNode {
  const ParagraphNode({
    required super.text,
    required super.rawText,
    this.children = const [],
  });

  /// Inline nodes within the paragraph (bold, italic, links, etc.).
  final List<AstNode> children;
}

/// Base class for inline text styling nodes.
sealed class InlineStyleNode extends AstNode {
  const InlineStyleNode({
    required super.text,
    required super.rawText,
    this.children = const [],
  });

  /// Inline nodes within this styled node (can nest bold, italic, links, etc.).
  final List<AstNode> children;
}

/// Represents bold text.
final class BoldNode extends InlineStyleNode {
  const BoldNode({required super.text, required super.rawText, super.children});
}

/// Represents italic text.
final class ItalicNode extends InlineStyleNode {
  const ItalicNode({
    required super.text,
    required super.rawText,
    super.children,
  });
}

/// Represents strikethrough text.
final class StrikethroughNode extends InlineStyleNode {
  const StrikethroughNode({
    required super.text,
    required super.rawText,
    super.children,
  });
}

/// Represents inline code.
final class InlineCodeNode extends InlineStyleNode {
  const InlineCodeNode({required super.text, required super.rawText});
}

/// Represents plain text (no special formatting).
final class TextNode extends AstNode {
  const TextNode({required super.text, required super.rawText});
}

/// Base class for list nodes.
sealed class ListNode extends AstNode {
  const ListNode({
    required super.text,
    required super.rawText,
    required this.items,
  });

  /// The list items.
  final List<ListItemNode> items;
}

/// Represents an unordered list.
final class UnorderedListNode extends ListNode {
  const UnorderedListNode({
    required super.text,
    required super.rawText,
    required super.items,
  });
}

/// Represents an ordered list.
final class OrderedListNode extends ListNode {
  const OrderedListNode({
    required super.text,
    required super.rawText,
    required super.items,
  });
}

/// Represents a list item.
final class ListItemNode extends AstNode {
  const ListItemNode({
    required super.text,
    required super.rawText,
    this.children = const [],
    this.isChecked,
  });

  /// Inline nodes within the list item.
  final List<AstNode> children;

  /// For checkbox items, whether the checkbox is checked.
  /// `null` if this is not a checkbox item.
  final bool? isChecked;
}

/// Represents a code block.
final class CodeBlockNode extends AstNode {
  const CodeBlockNode({
    required super.text,
    required super.rawText,
    this.language,
  });

  /// The language specified for the code block, if any.
  final String? language;
}

/// Represents a link.
final class LinkNode extends AstNode {
  const LinkNode({
    required super.text,
    required super.rawText,
    required this.url,
    this.children = const [],
  });

  /// The URL the link points to.
  final String url;

  /// Inline nodes within the link text (can contain bold, italic, etc.).
  final List<AstNode> children;
}

/// Represents a blockquote.
final class BlockquoteNode extends AstNode {
  const BlockquoteNode({
    required super.text,
    required super.rawText,
    this.children = const [],
  });

  /// Nodes within the blockquote.
  final List<AstNode> children;
}

/// Represents an empty line between blocks.
/// Carries no text; renderers should output a single newline for each instance.
final class BlankLineNode extends AstNode {
  const BlankLineNode() : super(text: '', rawText: '');
}
