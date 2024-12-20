import 'package:build_verify/build_verify.dart';
import 'package:test/test.dart';

void main() {
  test(
    'ensure_build',
    () => expectBuildClean(
      packageRelativeDirectory:
          'packages/riverpod_state_provider/riverpod_state_provider_generator/integration/build_yaml',
    ),
    timeout: const Timeout(Duration(minutes: 1)),
  );
}
