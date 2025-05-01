## 1.3.0

- Adds `AnimatedVisibility.builder`.

## 1.2.1

- Fix memory leaks in `AnimatedLocation`.

## 1.2.0

- Adds
  - `AnimatedFlexible`
  - `AnimatedExpanded`
  - `AnimatedSpacer`

## 1.1.0

- Adds `AnimatedAppearing`.

## 1.0.0

- Upgrade dependencies.
- Upgrades to Flutter 3.19 and Dart 3.2.
- **Breaking**: Removes `TightSizeTransition` as
  https://github.com/flutter/flutter/pull/134659 as been deployed on stable
  3.19.0. Use `SizeTransition` from Flutter instead.

## 0.0.2

- Uses the `duration` passed to the `AnimatedVisibility`.

## 0.0.1

- Updates the license and package description.

## 0.0.0

- Initial release:
  - Add `TickerFutureExtension` extension on `Future` with `whenCompleteOrCancelFuture` method.
  - Adds `AnimatedVisibility` widget.
  - Adds `AnimatedBooleanState` widget.
  - Adds `AnimatedLocation` widget.
  - Adds `TightSizeTransition` widget.
