@Timeout(Duration(minutes: 2))
library;

import 'package:build_verify/build_verify.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'Ensure build',
    () async => expectBuildClean(
      packageRelativeDirectory:
          'packages/static_json_serializable/examples/color_palette_example',
    ),
  );
}
