// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'int.dart';

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
