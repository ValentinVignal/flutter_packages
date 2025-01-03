// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'family.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$myFamilyPositionalParametersStateHash() =>
    r'985466c4ff10cba2b0828309e3afff87bb6eb126';

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

/// See also [_MyFamilyPositionalParametersState].
@ProviderFor(_MyFamilyPositionalParametersState)
const _myFamilyPositionalParametersStateProvider =
    _MyFamilyPositionalParametersStateFamily();

/// See also [_MyFamilyPositionalParametersState].
class _MyFamilyPositionalParametersStateFamily extends Family<int> {
  /// See also [_MyFamilyPositionalParametersState].
  const _MyFamilyPositionalParametersStateFamily();

  /// See also [_MyFamilyPositionalParametersState].
  _MyFamilyPositionalParametersStateProvider call(
    String param1,
    int param2,
    bool param3, [
    double param4 = 0.0,
    List<int>? param5,
  ]) {
    return _MyFamilyPositionalParametersStateProvider(
      param1,
      param2,
      param3,
      param4,
      param5,
    );
  }

  @override
  _MyFamilyPositionalParametersStateProvider getProviderOverride(
    covariant _MyFamilyPositionalParametersStateProvider provider,
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
  String? get name => r'_myFamilyPositionalParametersStateProvider';
}

/// See also [_MyFamilyPositionalParametersState].
class _MyFamilyPositionalParametersStateProvider
    extends AutoDisposeNotifierProviderImpl<_MyFamilyPositionalParametersState,
        int> {
  /// See also [_MyFamilyPositionalParametersState].
  _MyFamilyPositionalParametersStateProvider(
    String param1,
    int param2,
    bool param3, [
    double param4 = 0.0,
    List<int>? param5,
  ]) : this._internal(
          () => _MyFamilyPositionalParametersState()
            ..param1 = param1
            ..param2 = param2
            ..param3 = param3
            ..param4 = param4
            ..param5 = param5,
          from: _myFamilyPositionalParametersStateProvider,
          name: r'_myFamilyPositionalParametersStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myFamilyPositionalParametersStateHash,
          dependencies: _MyFamilyPositionalParametersStateFamily._dependencies,
          allTransitiveDependencies: _MyFamilyPositionalParametersStateFamily
              ._allTransitiveDependencies,
          param1: param1,
          param2: param2,
          param3: param3,
          param4: param4,
          param5: param5,
        );

  _MyFamilyPositionalParametersStateProvider._internal(
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
    covariant _MyFamilyPositionalParametersState notifier,
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
  Override overrideWith(_MyFamilyPositionalParametersState Function() create) {
    return ProviderOverride(
      origin: this,
      override: _MyFamilyPositionalParametersStateProvider._internal(
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
  AutoDisposeNotifierProviderElement<_MyFamilyPositionalParametersState, int>
      createElement() {
    return _MyFamilyPositionalParametersStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _MyFamilyPositionalParametersStateProvider &&
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
mixin _MyFamilyPositionalParametersStateRef
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
        _MyFamilyPositionalParametersState,
        int> with _MyFamilyPositionalParametersStateRef {
  _MyFamilyPositionalParametersStateProviderElement(super.provider);

  @override
  String get param1 =>
      (origin as _MyFamilyPositionalParametersStateProvider).param1;
  @override
  int get param2 =>
      (origin as _MyFamilyPositionalParametersStateProvider).param2;
  @override
  bool get param3 =>
      (origin as _MyFamilyPositionalParametersStateProvider).param3;
  @override
  double get param4 =>
      (origin as _MyFamilyPositionalParametersStateProvider).param4;
  @override
  List<int>? get param5 =>
      (origin as _MyFamilyPositionalParametersStateProvider).param5;
}

String _$myFamilyMixedParametersStateHash() =>
    r'2ba0f231b435c62b8b488c74b1ce693b2f3e61b4';

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

/// See also [_MyFamilyMixedParametersState].
@ProviderFor(_MyFamilyMixedParametersState)
const _myFamilyMixedParametersStateProvider =
    _MyFamilyMixedParametersStateFamily();

/// See also [_MyFamilyMixedParametersState].
class _MyFamilyMixedParametersStateFamily extends Family<List<bool>> {
  /// See also [_MyFamilyMixedParametersState].
  const _MyFamilyMixedParametersStateFamily();

  /// See also [_MyFamilyMixedParametersState].
  _MyFamilyMixedParametersStateProvider call(
    String param1,
    int param2, {
    required bool param3,
    double param4 = 0.0,
    List<int>? param5,
  }) {
    return _MyFamilyMixedParametersStateProvider(
      param1,
      param2,
      param3: param3,
      param4: param4,
      param5: param5,
    );
  }

  @override
  _MyFamilyMixedParametersStateProvider getProviderOverride(
    covariant _MyFamilyMixedParametersStateProvider provider,
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
  String? get name => r'_myFamilyMixedParametersStateProvider';
}

/// See also [_MyFamilyMixedParametersState].
class _MyFamilyMixedParametersStateProvider
    extends AutoDisposeNotifierProviderImpl<_MyFamilyMixedParametersState,
        List<bool>> {
  /// See also [_MyFamilyMixedParametersState].
  _MyFamilyMixedParametersStateProvider(
    String param1,
    int param2, {
    required bool param3,
    double param4 = 0.0,
    List<int>? param5,
  }) : this._internal(
          () => _MyFamilyMixedParametersState()
            ..param1 = param1
            ..param2 = param2
            ..param3 = param3
            ..param4 = param4
            ..param5 = param5,
          from: _myFamilyMixedParametersStateProvider,
          name: r'_myFamilyMixedParametersStateProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$myFamilyMixedParametersStateHash,
          dependencies: _MyFamilyMixedParametersStateFamily._dependencies,
          allTransitiveDependencies:
              _MyFamilyMixedParametersStateFamily._allTransitiveDependencies,
          param1: param1,
          param2: param2,
          param3: param3,
          param4: param4,
          param5: param5,
        );

  _MyFamilyMixedParametersStateProvider._internal(
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
    covariant _MyFamilyMixedParametersState notifier,
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
  Override overrideWith(_MyFamilyMixedParametersState Function() create) {
    return ProviderOverride(
      origin: this,
      override: _MyFamilyMixedParametersStateProvider._internal(
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
  AutoDisposeNotifierProviderElement<_MyFamilyMixedParametersState, List<bool>>
      createElement() {
    return _MyFamilyMixedParametersStateProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is _MyFamilyMixedParametersStateProvider &&
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
mixin _MyFamilyMixedParametersStateRef
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
    extends AutoDisposeNotifierProviderElement<_MyFamilyMixedParametersState,
        List<bool>> with _MyFamilyMixedParametersStateRef {
  _MyFamilyMixedParametersStateProviderElement(super.provider);

  @override
  String get param1 => (origin as _MyFamilyMixedParametersStateProvider).param1;
  @override
  int get param2 => (origin as _MyFamilyMixedParametersStateProvider).param2;
  @override
  bool get param3 => (origin as _MyFamilyMixedParametersStateProvider).param3;
  @override
  double get param4 => (origin as _MyFamilyMixedParametersStateProvider).param4;
  @override
  List<int>? get param5 =>
      (origin as _MyFamilyMixedParametersStateProvider).param5;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
