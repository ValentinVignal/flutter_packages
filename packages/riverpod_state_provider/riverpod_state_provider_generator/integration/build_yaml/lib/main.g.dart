// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myIntegerStateHash() => r'1a2e3285c9c180fad25467dd4114862e73620faa';

/// See also [MyIntegerState].
@ProviderFor(MyIntegerState)
final myIntegerStateProvider =
    AutoDisposeNotifierProvider<MyIntegerState, int>.internal(
  MyIntegerState.new,
  name: r'myIntegerStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myIntegerStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MyIntegerState = AutoDisposeNotifier<int>;
String _$myIntegerKeepAliveStateHash() =>
    r'7be403ad3c5115a10deefaec7c960fe0ff792ef4';

/// See also [MyIntegerKeepAliveState].
@ProviderFor(MyIntegerKeepAliveState)
final myIntegerKeepAliveStateProvider =
    NotifierProvider<MyIntegerKeepAliveState, int>.internal(
  MyIntegerKeepAliveState.new,
  name: r'myIntegerKeepAliveStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myIntegerKeepAliveStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MyIntegerKeepAliveState = Notifier<int>;
String _$myListStateHash() => r'b82ea856ae92d559e0b91a4803386d0545740595';

/// See also [MyListState].
@ProviderFor(MyListState)
final myListStateProvider =
    AutoDisposeNotifierProvider<MyListState, List<int>>.internal(
  MyListState.new,
  name: r'myListStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$myListStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MyListState = AutoDisposeNotifier<List<int>>;
String _$myListKeepAliveStateHash() =>
    r'9c23b1c06980eba216c74a8326e8e4fed92742eb';

/// See also [MyListKeepAliveState].
@ProviderFor(MyListKeepAliveState)
final myListKeepAliveStateProvider =
    NotifierProvider<MyListKeepAliveState, List<int>>.internal(
  MyListKeepAliveState.new,
  name: r'myListKeepAliveStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myListKeepAliveStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MyListKeepAliveState = Notifier<List<int>>;
String _$myFamilyPositionalParametersStateHash() =>
    r'eb3f9d771bef1e8a755bd46c1d72aefbd287bfe4';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MyFamilyPositionalParametersState
    extends BuildlessAutoDisposeNotifier<int> {
  late final String param1;
  late final int param2;
  late final bool param3;
  late final double param4;
  late final List<int>? param5;

  int build(
    String param1,
    int param2,
    bool param3, [
    double param4 = 0.0,
    List<int>? param5,
  ]);
}

/// See also [MyFamilyPositionalParametersState].
@ProviderFor(MyFamilyPositionalParametersState)
const myFamilyPositionalParametersStateProvider =
    MyFamilyPositionalParametersStateFamily();

/// See also [MyFamilyPositionalParametersState].
class MyFamilyPositionalParametersStateFamily extends Family<int> {
  /// See also [MyFamilyPositionalParametersState].
  const MyFamilyPositionalParametersStateFamily();

  /// See also [MyFamilyPositionalParametersState].
  MyFamilyPositionalParametersStateProvider call(
    String param1,
    int param2,
    bool param3, [
    double param4 = 0.0,
    List<int>? param5,
  ]) {
    return MyFamilyPositionalParametersStateProvider(
      param1,
      param2,
      param3,
      param4,
      param5,
    );
  }

  @override
  MyFamilyPositionalParametersStateProvider getProviderOverride(
    covariant MyFamilyPositionalParametersStateProvider provider,
  ) {
    return call(
      provider.param1,
      provider.param2,
      provider.param3,
      provider.param4,
      provider.param5,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'myFamilyPositionalParametersStateProvider';
}

/// See also [MyFamilyPositionalParametersState].
class MyFamilyPositionalParametersStateProvider
    extends AutoDisposeNotifierProviderImpl<MyFamilyPositionalParametersState,
        int> {
  /// See also [MyFamilyPositionalParametersState].
  MyFamilyPositionalParametersStateProvider(
    String param1,
    int param2,
    bool param3, [
    double param4 = 0.0,
    List<int>? param5,
  ]) : this._internal(
          () => MyFamilyPositionalParametersState()
            ..param1 = param1
            ..param2 = param2
            ..param3 = param3
            ..param4 = param4
            ..param5 = param5,
          from: myFamilyPositionalParametersStateProvider,
          name: r'myFamilyPositionalParametersStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myFamilyPositionalParametersStateHash,
          dependencies: MyFamilyPositionalParametersStateFamily._dependencies,
          allTransitiveDependencies: MyFamilyPositionalParametersStateFamily
              ._allTransitiveDependencies,
          param1: param1,
          param2: param2,
          param3: param3,
          param4: param4,
          param5: param5,
        );

  MyFamilyPositionalParametersStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param1,
    required this.param2,
    required this.param3,
    required this.param4,
    required this.param5,
  }) : super.internal();

  final String param1;
  final int param2;
  final bool param3;
  final double param4;
  final List<int>? param5;

  @override
  int runNotifierBuild(
    covariant MyFamilyPositionalParametersState notifier,
  ) {
    return notifier.build(
      param1,
      param2,
      param3,
      param4,
      param5,
    );
  }

  @override
  Override overrideWith(MyFamilyPositionalParametersState Function() create) {
    return ProviderOverride(
      origin: this,
      override: MyFamilyPositionalParametersStateProvider._internal(
        () => create()
          ..param1 = param1
          ..param2 = param2
          ..param3 = param3
          ..param4 = param4
          ..param5 = param5,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        param1: param1,
        param2: param2,
        param3: param3,
        param4: param4,
        param5: param5,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<MyFamilyPositionalParametersState, int>
      createElement() {
    return _MyFamilyPositionalParametersStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyFamilyPositionalParametersStateProvider &&
        other.param1 == param1 &&
        other.param2 == param2 &&
        other.param3 == param3 &&
        other.param4 == param4 &&
        other.param5 == param5;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, param1.hashCode);
    hash = _SystemHash.combine(hash, param2.hashCode);
    hash = _SystemHash.combine(hash, param3.hashCode);
    hash = _SystemHash.combine(hash, param4.hashCode);
    hash = _SystemHash.combine(hash, param5.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MyFamilyPositionalParametersStateRef
    on AutoDisposeNotifierProviderRef<int> {
  /// The parameter `param1` of this provider.
  String get param1;

  /// The parameter `param2` of this provider.
  int get param2;

  /// The parameter `param3` of this provider.
  bool get param3;

  /// The parameter `param4` of this provider.
  double get param4;

  /// The parameter `param5` of this provider.
  List<int>? get param5;
}

class _MyFamilyPositionalParametersStateProviderElement
    extends AutoDisposeNotifierProviderElement<
        MyFamilyPositionalParametersState,
        int> with MyFamilyPositionalParametersStateRef {
  _MyFamilyPositionalParametersStateProviderElement(super.provider);

  @override
  String get param1 =>
      (origin as MyFamilyPositionalParametersStateProvider).param1;
  @override
  int get param2 =>
      (origin as MyFamilyPositionalParametersStateProvider).param2;
  @override
  bool get param3 =>
      (origin as MyFamilyPositionalParametersStateProvider).param3;
  @override
  double get param4 =>
      (origin as MyFamilyPositionalParametersStateProvider).param4;
  @override
  List<int>? get param5 =>
      (origin as MyFamilyPositionalParametersStateProvider).param5;
}

String _$myFamilyMixedParametersStateHash() =>
    r'51a2fd5d1ae0e1c1e5a3a371c508f8795a0fcd0c';

abstract class _$MyFamilyMixedParametersState
    extends BuildlessAutoDisposeNotifier<List<bool>> {
  late final String param1;
  late final int param2;
  late final bool param3;
  late final double param4;
  late final List<int>? param5;

  List<bool> build(
    String param1,
    int param2, {
    required bool param3,
    double param4 = 0.0,
    List<int>? param5,
  });
}

/// See also [MyFamilyMixedParametersState].
@ProviderFor(MyFamilyMixedParametersState)
const myFamilyMixedParametersStateProvider =
    MyFamilyMixedParametersStateFamily();

/// See also [MyFamilyMixedParametersState].
class MyFamilyMixedParametersStateFamily extends Family<List<bool>> {
  /// See also [MyFamilyMixedParametersState].
  const MyFamilyMixedParametersStateFamily();

  /// See also [MyFamilyMixedParametersState].
  MyFamilyMixedParametersStateProvider call(
    String param1,
    int param2, {
    required bool param3,
    double param4 = 0.0,
    List<int>? param5,
  }) {
    return MyFamilyMixedParametersStateProvider(
      param1,
      param2,
      param3: param3,
      param4: param4,
      param5: param5,
    );
  }

  @override
  MyFamilyMixedParametersStateProvider getProviderOverride(
    covariant MyFamilyMixedParametersStateProvider provider,
  ) {
    return call(
      provider.param1,
      provider.param2,
      param3: provider.param3,
      param4: provider.param4,
      param5: provider.param5,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'myFamilyMixedParametersStateProvider';
}

/// See also [MyFamilyMixedParametersState].
class MyFamilyMixedParametersStateProvider
    extends AutoDisposeNotifierProviderImpl<MyFamilyMixedParametersState,
        List<bool>> {
  /// See also [MyFamilyMixedParametersState].
  MyFamilyMixedParametersStateProvider(
    String param1,
    int param2, {
    required bool param3,
    double param4 = 0.0,
    List<int>? param5,
  }) : this._internal(
          () => MyFamilyMixedParametersState()
            ..param1 = param1
            ..param2 = param2
            ..param3 = param3
            ..param4 = param4
            ..param5 = param5,
          from: myFamilyMixedParametersStateProvider,
          name: r'myFamilyMixedParametersStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myFamilyMixedParametersStateHash,
          dependencies: MyFamilyMixedParametersStateFamily._dependencies,
          allTransitiveDependencies:
              MyFamilyMixedParametersStateFamily._allTransitiveDependencies,
          param1: param1,
          param2: param2,
          param3: param3,
          param4: param4,
          param5: param5,
        );

  MyFamilyMixedParametersStateProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param1,
    required this.param2,
    required this.param3,
    required this.param4,
    required this.param5,
  }) : super.internal();

  final String param1;
  final int param2;
  final bool param3;
  final double param4;
  final List<int>? param5;

  @override
  List<bool> runNotifierBuild(
    covariant MyFamilyMixedParametersState notifier,
  ) {
    return notifier.build(
      param1,
      param2,
      param3: param3,
      param4: param4,
      param5: param5,
    );
  }

  @override
  Override overrideWith(MyFamilyMixedParametersState Function() create) {
    return ProviderOverride(
      origin: this,
      override: MyFamilyMixedParametersStateProvider._internal(
        () => create()
          ..param1 = param1
          ..param2 = param2
          ..param3 = param3
          ..param4 = param4
          ..param5 = param5,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        param1: param1,
        param2: param2,
        param3: param3,
        param4: param4,
        param5: param5,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<MyFamilyMixedParametersState, List<bool>>
      createElement() {
    return _MyFamilyMixedParametersStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MyFamilyMixedParametersStateProvider &&
        other.param1 == param1 &&
        other.param2 == param2 &&
        other.param3 == param3 &&
        other.param4 == param4 &&
        other.param5 == param5;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, param1.hashCode);
    hash = _SystemHash.combine(hash, param2.hashCode);
    hash = _SystemHash.combine(hash, param3.hashCode);
    hash = _SystemHash.combine(hash, param4.hashCode);
    hash = _SystemHash.combine(hash, param5.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MyFamilyMixedParametersStateRef
    on AutoDisposeNotifierProviderRef<List<bool>> {
  /// The parameter `param1` of this provider.
  String get param1;

  /// The parameter `param2` of this provider.
  int get param2;

  /// The parameter `param3` of this provider.
  bool get param3;

  /// The parameter `param4` of this provider.
  double get param4;

  /// The parameter `param5` of this provider.
  List<int>? get param5;
}

class _MyFamilyMixedParametersStateProviderElement
    extends AutoDisposeNotifierProviderElement<MyFamilyMixedParametersState,
        List<bool>> with MyFamilyMixedParametersStateRef {
  _MyFamilyMixedParametersStateProviderElement(super.provider);

  @override
  String get param1 => (origin as MyFamilyMixedParametersStateProvider).param1;
  @override
  int get param2 => (origin as MyFamilyMixedParametersStateProvider).param2;
  @override
  bool get param3 => (origin as MyFamilyMixedParametersStateProvider).param3;
  @override
  double get param4 => (origin as MyFamilyMixedParametersStateProvider).param4;
  @override
  List<int>? get param5 =>
      (origin as MyFamilyMixedParametersStateProvider).param5;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
