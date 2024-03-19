import 'package:flutter/material.dart';

/// A page to display a dialog.
class DialogPage extends Page<dynamic> {
  /// A page to display a dialog.
  const DialogPage({
    required this.child,
    super.key,
  });

  /// The widget to be displayed which is usually a [Dialog] widget.
  final Widget child;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    return DialogRoute(
      context: context,
      settings: this,
      builder: (context) => child,
    );
  }
}
