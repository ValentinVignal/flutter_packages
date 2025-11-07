import 'dart:ui';

import 'package:flutter/material.dart';

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
    return ClipRect(
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: TextField(
          controller: widget.controller ?? _controller,
          maxLines: null,
          expands: true,
          selectionHeightStyle: BoxHeightStyle.max,
          clipBehavior: Clip.none,
        ),
      ),
    );
  }
}
