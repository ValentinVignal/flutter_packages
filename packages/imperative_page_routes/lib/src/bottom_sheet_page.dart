import 'package:flutter/material.dart';

/// A page to display a bottom sheet.
class BottomSheetPage extends Page<dynamic> {
  /// A page to display a bottom sheet.
  const BottomSheetPage({
    required this.child,
    super.key,
  });

  /// The widget to be displayed which is usually a [BottomSheet] widget.
  final Widget child;

  @override
  Route<dynamic> createRoute(BuildContext context) {
    final NavigatorState navigator = Navigator.of(context);
    final MaterialLocalizations localizations =
        MaterialLocalizations.of(context);
    return ModalBottomSheetRoute(
      settings: this,
      builder: (context) => child,
      capturedThemes:
          InheritedTheme.capture(from: context, to: navigator.context),
      barrierLabel: localizations.scrimLabel,
      isScrollControlled: true,
      barrierOnTapHint:
          localizations.scrimOnTapHint(localizations.bottomSheetLabel),
      modalBarrierColor: Theme.of(context).bottomSheetTheme.modalBarrierColor,
    );
  }
}
