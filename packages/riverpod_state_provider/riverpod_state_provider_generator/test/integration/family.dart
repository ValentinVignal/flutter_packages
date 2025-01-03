import 'package:riverpod_state_provider_annotation/riverpod_state_provider_annotation.dart';

part 'family.g.dart';
part 'family.rsp.dart';

@RiverpodStateProvider()
int myFamilyPositionalParameters(String param1, int param2, bool param3,
    [double param4 = 0.0, List<int>? param5]) {
  return 0;
}

@RiverpodStateProvider()
List<bool> myFamilyMixedParameters(String param1, int param2,
    {required bool param3, double param4 = 0.0, List<int>? param5}) {
  return const [true];
}
