import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:riverpod_state_provider_annotation/riverpod_state_provider_annotation.dart';
import 'package:source_gen/source_gen.dart';

const _typeChecker = TypeChecker.fromRuntime(RiverpodStateProvider);

/// The generator that generates the code for the annotated elements.
@immutable
class RiverpodStateProviderGenerator
    extends GeneratorForAnnotation<RiverpodStateProvider> {
  const RiverpodStateProviderGenerator();

  @override
  Future<String?> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! FunctionElement) {
      throw InvalidGenerationSourceError(
        'The element annotated with @RiverpodStateProvider is not a function',
        element: element,
      );
    }

    return _generateProvider(annotation, element);
  }

  String _getType(ResolvedLibraryResult library, TypeAnnotation? returnType) {
    final createdDartType =
        returnType?.type ?? library.typeProvider.dynamicType;
    final typeSource = returnType?.toSource() ?? 'dynamic';
    if (createdDartType.isDartAsyncFuture ||
        createdDartType.isDartAsyncFutureOr ||
        createdDartType.isDartAsyncStream) {
      throw UnsupportedError(
        'Async types are not supported (Received $typeSource)',
      );
    }
    return typeSource;
  }

  String _buildParametersDefinition(List<ParameterElement> parameters) {
    final parametersToDefine = parameters.skip(1);
    final requiredPositionals = parametersToDefine
        .where((element) => element.isRequiredPositional)
        .toList();
    final optionalPositionals = parametersToDefine
        .where((element) => element.isOptionalPositional)
        .toList();
    final named =
        parametersToDefine.where((element) => element.isNamed).toList();

    final buffer = StringBuffer();
    String encodeParameter(ParameterElement e) {
      final leading = e.isRequiredNamed ? 'required ' : '';
      final trailing =
          e.defaultValueCode != null ? '= ${e.defaultValueCode}' : '';
      return '$leading${e.type} ${e.name}$trailing';
    }

    buffer.writeAll(
      requiredPositionals.map(encodeParameter).expand((e) => [e, ',']),
    );
    if (optionalPositionals.isNotEmpty) {
      buffer.write('[');
      buffer.writeAll(
        optionalPositionals.map(encodeParameter).expand((e) => [e, ',']),
      );
      buffer.write(']');
    }
    if (named.isNotEmpty) {
      buffer.write('{');
      buffer.writeAll(named.map(encodeParameter).expand((e) => [e, ',']));
      buffer.write('}');
    }

    return buffer.toString();
  }

  String _buildParametersInvocation(List<ParameterElement> parameters) {
    final buffer = StringBuffer();

    buffer.writeAll(
      parameters.mapIndexed((i, e) {
        if (i == 0) return 'ref';
        if (e.isNamed) return '${e.name}: ${e.name}';
        return e.name;
      }).expand((e) => [e, ',']),
    );

    return buffer.toString();
  }

  String _getExtensionType({
    required String stateClassName,
    required String type,
    required bool isFamily,
    required bool isKeepAlive,
  }) {
    if (!isFamily) {
      final prefix = isKeepAlive ? '' : 'AutoDispose';
      return '${prefix}NotifierProvider<$stateClassName, $type>';
    } else {
      return '${stateClassName}Provider';
    }
  }

  String _getDecorator(ConstantReader annotation) {
    final isKeepAlive = annotation.peek('keepAlive')?.boolValue ?? false;

    final dependencies = annotation.peek('dependencies')?.listValue;

    if (isKeepAlive || dependencies != null) {
      final builder = StringBuffer('@Riverpod(');

      if (isKeepAlive) {
        builder.write('keepAlive: true,');
      }
      if (dependencies != null) {
        builder.write('dependencies: [');
        builder.write(dependencies.map((dependency) {
          final type = dependency.toTypeValue();
          if (type != null) {
            // It is a mandatory parameter for flutter 3.19.
            // ignore: deprecated_member_use
            return type.getDisplayString(withNullability: true);
          } else {
            final function = dependency.toFunctionValue()! as FunctionElement;
            final annotation = _typeChecker.firstAnnotationOfExact(function);
            if (annotation == null) {
              return function.name;
            }
            return _getStateClassNameFromFunctionName(function.name);
          }
        }).join(', '));
        builder.write('],');
      }
      builder.writeln(')');

      return builder.toString();
    }
    return '@riverpod';
  }

  String _getStateClassNameFromFunctionName(String name) {
    final pascalName = name.camelToPascal();
    return '${pascalName}State';
  }

  Future<String> _generateProvider(
    ConstantReader annotation,
    FunctionElement element,
  ) async {
    final isKeepAlive = annotation.peek('keepAlive')?.boolValue ?? false;

    final library = await element.session
        ?.getResolvedLibraryByElement(element.library) as ResolvedLibraryResult;
    final functionDeclaration =
        library.getElementDeclaration(element)?.node as FunctionDeclaration;

    final parameters = element.parameters;
    final isFamily = parameters.length > 1;

    final type = _getType(library, functionDeclaration.returnType);

    final name = element.name;
    final pascalName = name.camelToPascal();
    final stateClassName = _getStateClassNameFromFunctionName(name);

    final buffer = StringBuffer();
    buffer.write('''
@StateProviderFor($name)
${_getDecorator(annotation)}
class $stateClassName extends _\$$stateClassName {
  $stateClassName({this.overrideInitialState});

  final ValueOverride<$type>? overrideInitialState;

  @override
  $type build(${_buildParametersDefinition(parameters)}) {
    if (overrideInitialState != null) {
      return overrideInitialState!.value;
    }
    return $name(${_buildParametersInvocation(parameters)});
  }

  @override
  $type get state => super.state;

  @override
  set state($type value) => super.state = value;

  /// Calls a function with the current [state] and assigns the result as the
  /// new state.
  ///
  /// This allows simplifying the syntax for updating the state when the update
  /// depends on the previous state, such that rather than:
  ///
  /// ```dart
  /// ref.read(provider.notifier).state = ref.read(provider.notifier).state + 1;
  /// ```
  ///
  /// we can do:
  ///
  /// ```dart
  /// ref.read(provider.notifier).update((state) => state + 1);
  /// ```
  $type update($type Function($type state) cb) => state = cb(state);
}

extension ${pascalName}RiverpodStateProviderExtension
    on ${_getExtensionType(isFamily: isFamily, stateClassName: stateClassName, type: type, isKeepAlive: isKeepAlive)} {
  Override overrideWithValue($type value) {
    return overrideWith(() {
      return $stateClassName(
        overrideInitialState: ValueOverride<$type>(value),
      );
    });
  }
}
''');

    return buffer.toString();
  }
}

extension on String {
  String camelToPascal() {
    if (isEmpty) return '';
    return this[0].toUpperCase() + substring(1);
  }
}

extension<T> on Iterable<T> {
  Iterable<R> mapIndexed<R>(R Function(int index, T element) convert) sync* {
    var index = 0;
    for (var element in this) {
      yield convert(index++, element);
    }
  }
}
