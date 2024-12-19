// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$counterHash() => r'4243b34530f53accfd9014a9f0e316fe304ada3e';

/// See also [Counter].
@ProviderFor(Counter)
final counterProvider = AutoDisposeNotifierProvider<Counter, int>.internal(
  Counter.new,
  name: r'counterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$counterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Counter = AutoDisposeNotifier<int>;
String _$counterFamilyHash() => r'408ec7a19dd8653ce04782aabc25bbe684dfc896';

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

abstract class _$CounterFamily extends BuildlessAutoDisposeNotifier<int> {
  late final String param;

  int build(
    String param,
  );
}

/// See also [CounterFamily].
@ProviderFor(CounterFamily)
const counterFamilyProvider = CounterFamilyFamily();

/// See also [CounterFamily].
class CounterFamilyFamily extends Family<int> {
  /// See also [CounterFamily].
  const CounterFamilyFamily();

  /// See also [CounterFamily].
  CounterFamilyProvider call(
    String param,
  ) {
    return CounterFamilyProvider(
      param,
    );
  }

  @override
  CounterFamilyProvider getProviderOverride(
    covariant CounterFamilyProvider provider,
  ) {
    return call(
      provider.param,
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
  String? get name => r'counterFamilyProvider';
}

/// See also [CounterFamily].
class CounterFamilyProvider
    extends AutoDisposeNotifierProviderImpl<CounterFamily, int> {
  /// See also [CounterFamily].
  CounterFamilyProvider(
    String param,
  ) : this._internal(
          () => CounterFamily()..param = param,
          from: counterFamilyProvider,
          name: r'counterFamilyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$counterFamilyHash,
          dependencies: CounterFamilyFamily._dependencies,
          allTransitiveDependencies:
              CounterFamilyFamily._allTransitiveDependencies,
          param: param,
        );

  CounterFamilyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.param,
  }) : super.internal();

  final String param;

  @override
  int runNotifierBuild(
    covariant CounterFamily notifier,
  ) {
    return notifier.build(
      param,
    );
  }

  @override
  Override overrideWith(CounterFamily Function() create) {
    return ProviderOverride(
      origin: this,
      override: CounterFamilyProvider._internal(
        () => create()..param = param,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        param: param,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<CounterFamily, int> createElement() {
    return _CounterFamilyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CounterFamilyProvider && other.param == param;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, param.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CounterFamilyRef on AutoDisposeNotifierProviderRef<int> {
  /// The parameter `param` of this provider.
  String get param;
}

class _CounterFamilyProviderElement
    extends AutoDisposeNotifierProviderElement<CounterFamily, int>
    with CounterFamilyRef {
  _CounterFamilyProviderElement(super.provider);

  @override
  String get param => (origin as CounterFamilyProvider).param;
}

String _$myIntegerStateHash() => r'6e0f5229d73367854236933bac07bb267ad733af';

/// See also [_MyIntegerState].
@ProviderFor(_MyIntegerState)
final _myIntegerStateProvider =
    AutoDisposeNotifierProvider<_MyIntegerState, int>.internal(
  _MyIntegerState.new,
  name: r'_myIntegerStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myIntegerStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MyIntegerState = AutoDisposeNotifier<int>;
String _$myNullableIntegerStateHash() =>
    r'5d345c366b4d13274df39556143753d944de5879';

/// See also [_MyNullableIntegerState].
@ProviderFor(_MyNullableIntegerState)
final _myNullableIntegerStateProvider =
    AutoDisposeNotifierProvider<_MyNullableIntegerState, int?>.internal(
  _MyNullableIntegerState.new,
  name: r'_myNullableIntegerStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myNullableIntegerStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MyNullableIntegerState = AutoDisposeNotifier<int?>;
String _$myDoubleStateHash() => r'c5658e796087ab01d5ab1e4e28589b15eed071aa';

/// See also [_MyDoubleState].
@ProviderFor(_MyDoubleState)
final _myDoubleStateProvider =
    AutoDisposeNotifierProvider<_MyDoubleState, double>.internal(
  _MyDoubleState.new,
  name: r'_myDoubleStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myDoubleStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MyDoubleState = AutoDisposeNotifier<double>;
String _$myClassIntegerStateHash() =>
    r'58b0b15292bca21b4e5ca48f676039f26e5d1cee';

/// See also [_MyClassIntegerState].
@ProviderFor(_MyClassIntegerState)
final _myClassIntegerStateProvider =
    AutoDisposeNotifierProvider<_MyClassIntegerState, MyClass<int>>.internal(
  _MyClassIntegerState.new,
  name: r'_myClassIntegerStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myClassIntegerStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MyClassIntegerState = AutoDisposeNotifier<MyClass<int>>;
String _$mySetIntegerStateHash() => r'426cdc972b2e9127483d263f37935002633ffe56';

/// See also [_MySetIntegerState].
@ProviderFor(_MySetIntegerState)
final _mySetIntegerStateProvider =
    AutoDisposeNotifierProvider<_MySetIntegerState, Set<int>>.internal(
  _MySetIntegerState.new,
  name: r'_mySetIntegerStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$mySetIntegerStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MySetIntegerState = AutoDisposeNotifier<Set<int>>;
String _$myListIntegerStateHash() =>
    r'b30e539f227906bb79bf29305cf1616ead11fac2';

/// See also [_MyListIntegerState].
@ProviderFor(_MyListIntegerState)
final _myListIntegerStateProvider =
    AutoDisposeNotifierProvider<_MyListIntegerState, List<int>>.internal(
  _MyListIntegerState.new,
  name: r'_myListIntegerStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myListIntegerStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MyListIntegerState = AutoDisposeNotifier<List<int>>;
String _$myMapIntegerStateHash() => r'864251f957801e31caf02e454034a6487a0fdab4';

/// See also [_MyMapIntegerState].
@ProviderFor(_MyMapIntegerState)
final _myMapIntegerStateProvider =
    AutoDisposeNotifierProvider<_MyMapIntegerState, Map<int, int>>.internal(
  _MyMapIntegerState.new,
  name: r'_myMapIntegerStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$myMapIntegerStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$MyMapIntegerState = AutoDisposeNotifier<Map<int, int>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
