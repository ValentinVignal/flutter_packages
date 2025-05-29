import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:source_gen/source_gen.dart';
import 'package:static_json_serializable_annotation/static_json_serializable_annotation.dart';

// cspell:ignore decapitalize

/// The generator for the `@StaticJsonSerializable` annotation.
@immutable
class StaticJsonSerializableGenerator
    extends GeneratorForAnnotation<StaticJsonSerializable> {
  /// The generator for the `@StaticJsonSerializable` annotation.
  const StaticJsonSerializableGenerator();

  @override
  Iterable<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement) {
      throw InvalidGenerationSourceError(
        '`@StaticJsonSerializable` can only be used on classes.',
        element: element,
      );
    }

    final name = element.name;

    final staticFields =
        element.fields.where((field) => field.isStatic && field.isConst);

    return [
      'const \$${name.decapitalize()}StaticJson = {',
      for (final field in staticFields) "'${field.name}': $name.${field.name},",
      '};'
    ];
  }
}

extension on String {
  String decapitalize() {
    if (isEmpty) return this;
    return '${this[0].toLowerCase()}${substring(1)}';
  }
}
