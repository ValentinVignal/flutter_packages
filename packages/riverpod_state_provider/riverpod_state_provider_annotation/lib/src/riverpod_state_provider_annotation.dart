import 'package:meta/meta.dart';
import 'package:meta/meta_meta.dart';

/// {@template riverpod_state_provider_annotation}
/// An annotation placed on functions.
///
/// This tells riverpod_state_provider_annotation to generate a provider out of
/// the annotated.
///
/// By default, Riverpod will convert [Future]s and [Stream]s into
/// [AsyncValue]s. If this is undesired, you can use [Raw] to have Riverpod
/// forcibly return the raw [Future]/[Stream] instead.
/// {@endtemplate}
@Target({TargetKind.function})
class RiverpodStateProvider {
  /// {@macro riverpod_state_provider_annotation}
  const RiverpodStateProvider({
    this.keepAlive = false,
    this.dependencies,
  });

  /// Whether the state of the provider should be maintained if it is no-longer used.
  ///
  /// Defaults to false.
  final bool keepAlive;

  /// The dependencies of the provider.
  final List<Object>? dependencies;
}

/// An annotation used to help find the user-defined element from the generated
/// provider.
///
/// DO NOT USE
class StateProviderFor {
  /// An annotation used to help find the user-defined element from the
  /// generated provider.
  // Put the annotation on the constructor to avoid the linter from complaining
  // about the annotation being exported; while preventing the user from using it.
  @internal
  const StateProviderFor(this.value)
      : assert(
          value is Function,
          '$value is not a function',
        );

  /// The code annotated by `@RiverpodStateProvider`
  final Object value;
}
