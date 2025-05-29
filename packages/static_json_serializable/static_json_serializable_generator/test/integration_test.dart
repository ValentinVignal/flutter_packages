import 'package:test/test.dart';

import 'integration/integration.dart';

void main() {
  test('It should generate static JSON for static fields', () {
    expect($intClassStaticJson, hasLength(2));
    expect(
        $intClassStaticJson['staticConstValue1'], IntClass.staticConstValue1);
    expect(
        $intClassStaticJson['staticConstValue2'], IntClass.staticConstValue2);
  });
}
