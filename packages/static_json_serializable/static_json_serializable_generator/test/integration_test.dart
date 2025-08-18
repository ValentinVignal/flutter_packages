import 'package:test/test.dart';

import 'integration/const_only.dart';
import 'integration/integration.dart';

void main() {
  group('integration.dart', () {
    test('It should generate static JSON for static fields', () {
      expect($intClassStaticJson, hasLength(4));
      expect(
          $intClassStaticJson['staticConstValue1'], IntClass.staticConstValue1);
      expect(
          $intClassStaticJson['staticConstValue2'], IntClass.staticConstValue2);
      expect(
          $intClassStaticJson['staticFinalValue1'], IntClass.staticFinalValue1);
      expect(
          $intClassStaticJson['staticFinalValue2'], IntClass.staticFinalValue2);
    });
  });

  group('const_only.dart', () {
    test('It should generate static JSON for const fields only', () {
      expect($constOnlyClassStaticJson, hasLength(2));
      expect($constOnlyClassStaticJson['staticConstValue1'],
          ConstOnlyClass.staticConstValue1);
      expect($constOnlyClassStaticJson['staticConstValue2'],
          ConstOnlyClass.staticConstValue2);
    });
  });
}
