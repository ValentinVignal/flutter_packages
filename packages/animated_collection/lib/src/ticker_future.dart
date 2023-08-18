import 'package:flutter/material.dart';

/// An extension on [TickerFuture].
extension TickerFutureExtension on TickerFuture {
  // We don't want to do anything.
  void _thunk(dynamic value) {}

  /// Future that resolves when the ticker is completed or is cancelled.
  Future<void> get whenCompleteOrCancelFuture {
    // We also want to specify the `onError` callback.
    // ignore: prefer-async-await
    return orCancel.then<void>(_thunk, onError: _thunk);
  }
}
