// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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
