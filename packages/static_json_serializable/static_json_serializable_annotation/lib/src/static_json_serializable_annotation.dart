import 'package:meta/meta_meta.dart';

/// {@template static_json_serializable_annotation.StaticJsonSerializable}
/// An annotation to specify a class to generate the code for.
/// {@endtemplate}
@Target({TargetKind.classType})
class StaticJsonSerializable {
  /// {@macro static_json_serializable_annotation.StaticJsonSerializable}
  const StaticJsonSerializable();
}
