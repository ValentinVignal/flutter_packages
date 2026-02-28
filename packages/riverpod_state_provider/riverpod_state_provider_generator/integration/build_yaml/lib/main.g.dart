// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MyIntegerState)
@StateProviderFor(myInteger)
final myIntegerStateProvider = MyIntegerStateProvider._();

@StateProviderFor(myInteger)
final class MyIntegerStateProvider
    extends $NotifierProvider<MyIntegerState, int> {
  MyIntegerStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'myIntegerStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$myIntegerStateHash();

  @$internal
  @override
  MyIntegerState create() => MyIntegerState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$myIntegerStateHash() => r'95af481ddad2d13ef47aac9e77381d34803f145c';

@StateProviderFor(myInteger)
abstract class _$MyIntegerState extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element = ref.element
        as $ClassProviderElement<AnyNotifier<int, int>, int, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(MyIntegerKeepAliveState)
@StateProviderFor(myIntegerKeepAlive)
final myIntegerKeepAliveStateProvider = MyIntegerKeepAliveStateProvider._();

@StateProviderFor(myIntegerKeepAlive)
final class MyIntegerKeepAliveStateProvider
    extends $NotifierProvider<MyIntegerKeepAliveState, int> {
  MyIntegerKeepAliveStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'myIntegerKeepAliveStateProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$myIntegerKeepAliveStateHash();

  @$internal
  @override
  MyIntegerKeepAliveState create() => MyIntegerKeepAliveState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }
}

String _$myIntegerKeepAliveStateHash() =>
    r'4b33b1bee9c4d98738aa9d26d4422caf73292bb3';

@StateProviderFor(myIntegerKeepAlive)
abstract class _$MyIntegerKeepAliveState extends $Notifier<int> {
  int build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element = ref.element
        as $ClassProviderElement<AnyNotifier<int, int>, int, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(MyListState)
@StateProviderFor(myList)
final myListStateProvider = MyListStateProvider._();

@StateProviderFor(myList)
final class MyListStateProvider
    extends $NotifierProvider<MyListState, List<int>> {
  MyListStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'myListStateProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$myListStateHash();

  @$internal
  @override
  MyListState create() => MyListState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<int>>(value),
    );
  }
}

String _$myListStateHash() => r'029c2cad864b93fd43aa7090021ea28dec711159';

@StateProviderFor(myList)
abstract class _$MyListState extends $Notifier<List<int>> {
  List<int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<int>, List<int>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<int>, List<int>>, List<int>, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(MyListKeepAliveState)
@StateProviderFor(myListKeepAlive)
final myListKeepAliveStateProvider = MyListKeepAliveStateProvider._();

@StateProviderFor(myListKeepAlive)
final class MyListKeepAliveStateProvider
    extends $NotifierProvider<MyListKeepAliveState, List<int>> {
  MyListKeepAliveStateProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'myListKeepAliveStateProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$myListKeepAliveStateHash();

  @$internal
  @override
  MyListKeepAliveState create() => MyListKeepAliveState();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<int> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<int>>(value),
    );
  }
}

String _$myListKeepAliveStateHash() =>
    r'e0fcc66f1cbdce320a78a4fcaabece6d6168367f';

@StateProviderFor(myListKeepAlive)
abstract class _$MyListKeepAliveState extends $Notifier<List<int>> {
  List<int> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<int>, List<int>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<int>, List<int>>, List<int>, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

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
