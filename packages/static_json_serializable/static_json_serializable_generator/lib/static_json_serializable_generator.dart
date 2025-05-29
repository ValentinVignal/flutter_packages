import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:static_json_serializable_generator/src/static_json_serializable_generator.dart';

/// Supports `package:build_runner` creation and configuration of
/// `static_json_serializable`.
///
/// Not meant to be invoked by hand-authored code.
Builder staticJsonSerializable(BuilderOptions options) {
  return SharedPartBuilder(
    const [StaticJsonSerializableGenerator()],
    'static_json_serializable',
  );
}
