import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'text_editing_controller.dart';

class MarkdownLiteEditor extends StatefulWidget {
  const MarkdownLiteEditor({this.controller, super.key});

  final MarkdownTextEditingController? controller;

  @override
  State<MarkdownLiteEditor> createState() => _MarkdownLiteEditorState();
}

class _MarkdownLiteEditorState extends State<MarkdownLiteEditor> {
  final _controller = MarkdownTextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller ?? _controller;

    return ClipRect(
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: TextField(
          controller: controller,
          maxLines: null,
          expands: true,
          selectionHeightStyle: BoxHeightStyle.max,
          clipBehavior: Clip.none,
          contextMenuBuilder: (context, editableTextState) {
            final buttonItems = <ContextMenuButtonItem>[
              ...editableTextState.contextMenuButtonItems,
            ];

            // Check if cursor is on a link or code
            final selection =
                editableTextState.currentTextEditingValue.selection;
            final cursorPosition = selection.baseOffset;
            final linkUrl = controller.getLinkAtPosition(cursorPosition);
            final codeContent = controller.getCodeAtPosition(cursorPosition);

            if (linkUrl != null) {
              // Add "Open Link" button
              buttonItems.addAll([
                ContextMenuButtonItem(
                  label: 'Open Link',
                  type: ContextMenuButtonType.searchWeb,
                  onPressed: () async {
                    ContextMenuController.removeAny();
                    final uri = Uri.tryParse(linkUrl);
                    if (uri != null) {
                      await launchUrl(uri);
                    }
                  },
                ),
                ContextMenuButtonItem(
                  label: 'Copy Link Address',
                  type: ContextMenuButtonType.copy,
                  onPressed: () async {
                    ContextMenuController.removeAny();
                    await Clipboard.setData(ClipboardData(text: linkUrl));
                  },
                ),
              ]);
            }

            if (codeContent != null) {
              // Add "Copy Code" button
              buttonItems.add(
                ContextMenuButtonItem(
                  label: 'Copy Code',
                  type: ContextMenuButtonType.copy,
                  onPressed: () async {
                    ContextMenuController.removeAny();
                    await Clipboard.setData(ClipboardData(text: codeContent));
                  },
                ),
              );
            }

            return AdaptiveTextSelectionToolbar.buttonItems(
              anchors: editableTextState.contextMenuAnchors,
              buttonItems: buttonItems,
            );
          },
        ),
      ),
    );
  }
}
