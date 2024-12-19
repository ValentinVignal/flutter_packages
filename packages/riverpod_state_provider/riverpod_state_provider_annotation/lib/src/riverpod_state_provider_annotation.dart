import 'package:meta/meta_meta.dart';

/// An annotation placed on functions.
///
/// This tells riverpod_state_provider_annotation to generate a provider out of
/// the annotated.
///
/// By default, Riverpod will convert [Future]s and [Stream]s into
/// [AsyncValue]s. If this is undesired, you can use [Raw] to have Riverpod
/// forcibly return the raw [Future]/[Stream] instead.
@Target({TargetKind.function})
class RiverpodStateProvider {
  const RiverpodStateProvider();
}
