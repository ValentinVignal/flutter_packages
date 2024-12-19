import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/src/builder/build_step.dart';
import 'package:meta/meta.dart';
import 'package:riverpod_state_provider_annotation/riverpod_state_provider_annotation.dart';
import 'package:source_gen/source_gen.dart';

// TODO:
// - parameters
//

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

    return _generateProvider(element);
  }

  Future<String> _generateProvider(FunctionElement element) async {
    final library = await element.session
        ?.getResolvedLibraryByElement(element.library) as ResolvedLibraryResult;
    final functionDeclaration =
        library.getElementDeclaration(element)?.node as FunctionDeclaration;
    final returnedType =
        functionDeclaration.returnType?.toSource() ?? 'dynamic';

    final name = element.name;
    final pascalName = name.camelToPascal();
    final stateClassName = '${pascalName}State';

    final buffer = StringBuffer();
    buffer.write('''
final ${name}Provider = _${name}StateProvider;

@riverpod
class _$stateClassName extends _\$$stateClassName {
  _$stateClassName({this.overrideInitialState});

  final _${pascalName}OverrideValue? overrideInitialState;

  @override
  $returnedType build() {
    if (overrideInitialState != null) {
      return overrideInitialState!.value;
    }
    return $name();
  }

  @override
  $returnedType get state => super.state;

  @override
  set state($returnedType value) => super.state = value;

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
  $returnedType update($returnedType Function($returnedType state) cb) => state = cb(state);
}

class _${pascalName}OverrideValue {
  const _${pascalName}OverrideValue(this.value);

  final $returnedType value;
}

extension ${pascalName}RiverpodStateProviderExtension
    on AutoDisposeNotifierProvider<_$stateClassName, $returnedType> {
  Override overrideWithValue($returnedType value) {
    return overrideWith(() {
      return _$stateClassName(
        overrideInitialState: _${pascalName}OverrideValue(value),
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
