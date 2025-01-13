import 'package:riverpod/riverpod.dart';
import 'package:riverpod_state_provider_annotation/riverpod_state_provider_annotation.dart';

part 'main.g.dart';
part 'main.rsp.dart';

@RiverpodStateProvider()
int myInteger() {
  return 0;
}

@RiverpodStateProvider(keepAlive: true)
int myIntegerKeepAlive() {
  return 0;
}

@RiverpodStateProvider()
List<int> myList() {
  return const [0];
}

@RiverpodStateProvider(keepAlive: true)
List<int> myListKeepAlive() {
  return const [0];
}

@RiverpodStateProvider()
int myFamilyPositionalParameters(
    Ref ref, String param1, int param2, bool param3,
    [double param4 = 0.0, List<int>? param5]) {
  return 0;
}

@RiverpodStateProvider()
List<bool> myFamilyMixedParameters(Ref ref, String param1, int param2,
    {required bool param3, double param4 = 0.0, List<int>? param5}) {
  return const [true];
}
