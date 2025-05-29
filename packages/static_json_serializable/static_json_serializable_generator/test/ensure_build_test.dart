import 'package:build_verify/build_verify.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Ensure build',
    () async => expectBuildClean(
      packageRelativeDirectory:
          'packages/static_json_serializable/static_json_serializable_generator',
    ),
  );
}
