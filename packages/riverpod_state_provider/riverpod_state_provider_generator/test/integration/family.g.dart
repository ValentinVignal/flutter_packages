// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MyFamilyPositionalParametersState)
@StateProviderFor(myFamilyPositionalParameters)
final myFamilyPositionalParametersStateProvider =
    MyFamilyPositionalParametersStateFamily._();

@StateProviderFor(myFamilyPositionalParameters)
final class MyFamilyPositionalParametersStateProvider
    extends $NotifierProvider<MyFamilyPositionalParametersState, int> {
  MyFamilyPositionalParametersStateProvider._(
      {required MyFamilyPositionalParametersStateFamily super.from,
      required (
        String,
        int,
        bool,
        double,
        List<int>?,
      )
          super.argument})
      : super(
          retry: null,
          name: r'myFamilyPositionalParametersStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() =>
      _$myFamilyPositionalParametersStateHash();

  @override
  String toString() {
    return r'myFamilyPositionalParametersStateProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  MyFamilyPositionalParametersState create() =>
      MyFamilyPositionalParametersState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MyFamilyPositionalParametersStateProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$myFamilyPositionalParametersStateHash() =>
    r'117914bbe0c638388fe932b9cf23ab931d63e4d8';

@StateProviderFor(myFamilyPositionalParameters)
final class MyFamilyPositionalParametersStateFamily extends $Family
    with
        $ClassFamilyOverride<
            MyFamilyPositionalParametersState,
            int,
            int,
            int,
            (
              String,
              int,
              bool,
              double,
              List<int>?,
            )> {
  MyFamilyPositionalParametersStateFamily._()
      : super(
          retry: null,
          name: r'myFamilyPositionalParametersStateProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  @StateProviderFor(myFamilyPositionalParameters)
  MyFamilyPositionalParametersStateProvider call(
    String param1,
    int param2,
    bool param3, [
    double param4 = 0.0,
    List<int>? param5,
  ]) =>
      MyFamilyPositionalParametersStateProvider._(argument: (
        param1,
        param2,
        param3,
        param4,
        param5,
      ), from: this);

  @override
  String toString() => r'myFamilyPositionalParametersStateProvider';
}

@StateProviderFor(myFamilyPositionalParameters)
abstract class _$MyFamilyPositionalParametersState extends $Notifier<int> {
  late final _$args = ref.$arg as (
    String,
    int,
    bool,
    double,
    List<int>?,
  );
  String get param1 => _$args.$1;
  int get param2 => _$args.$2;
  bool get param3 => _$args.$3;
  double get param4 => _$args.$4;
  List<int>? get param5 => _$args.$5;

  int build(
    String param1,
    int param2,
    bool param3, [
    double param4 = 0.0,
    List<int>? param5,
  ]);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element = ref.element
        as $ClassProviderElement<AnyNotifier<int, int>, int, Object?, Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args.$1,
              _$args.$2,
              _$args.$3,
              _$args.$4,
              _$args.$5,
            ));
  }
}

@ProviderFor(MyFamilyMixedParametersState)
@StateProviderFor(myFamilyMixedParameters)
final myFamilyMixedParametersStateProvider =
    MyFamilyMixedParametersStateFamily._();

@StateProviderFor(myFamilyMixedParameters)
final class MyFamilyMixedParametersStateProvider
    extends $NotifierProvider<MyFamilyMixedParametersState, List<bool>> {
  MyFamilyMixedParametersStateProvider._(
      {required MyFamilyMixedParametersStateFamily super.from,
      required (
        String,
        int, {
        bool param3,
        double param4,
        List<int>? param5,
      })
          super.argument})
      : super(
          retry: null,
          name: r'myFamilyMixedParametersStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$myFamilyMixedParametersStateHash();

  @override
  String toString() {
    return r'myFamilyMixedParametersStateProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  MyFamilyMixedParametersState create() => MyFamilyMixedParametersState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<bool> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<bool>>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is MyFamilyMixedParametersStateProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$myFamilyMixedParametersStateHash() =>
    r'ef8c2e70a6181dda514b5ad0efd827780e2bd6a4';

@StateProviderFor(myFamilyMixedParameters)
final class MyFamilyMixedParametersStateFamily extends $Family
    with
        $ClassFamilyOverride<
            MyFamilyMixedParametersState,
            List<bool>,
            List<bool>,
            List<bool>,
            (
              String,
              int, {
              bool param3,
              double param4,
              List<int>? param5,
            })> {
  MyFamilyMixedParametersStateFamily._()
      : super(
          retry: null,
          name: r'myFamilyMixedParametersStateProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  @StateProviderFor(myFamilyMixedParameters)
  MyFamilyMixedParametersStateProvider call(
    String param1,
    int param2, {
    required bool param3,
    double param4 = 0.0,
    List<int>? param5,
  }) =>
      MyFamilyMixedParametersStateProvider._(argument: (
        param1,
        param2,
        param3: param3,
        param4: param4,
        param5: param5,
      ), from: this);

  @override
  String toString() => r'myFamilyMixedParametersStateProvider';
}

@StateProviderFor(myFamilyMixedParameters)
abstract class _$MyFamilyMixedParametersState extends $Notifier<List<bool>> {
  late final _$args = ref.$arg as (
    String,
    int, {
    bool param3,
    double param4,
    List<int>? param5,
  });
  String get param1 => _$args.$1;
  int get param2 => _$args.$2;
  bool get param3 => _$args.param3;
  double get param4 => _$args.param4;
  List<int>? get param5 => _$args.param5;

  List<bool> build(
    String param1,
    int param2, {
    required bool param3,
    double param4 = 0.0,
    List<int>? param5,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<bool>, List<bool>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<bool>, List<bool>>, List<bool>, Object?, Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args.$1,
              _$args.$2,
              param3: _$args.param3,
              param4: _$args.param4,
              param5: _$args.param5,
            ));
  }
}
