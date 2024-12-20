import 'package:riverpod_state_provider_annotation/riverpod_state_provider_annotation.dart';

part 'main.g.dart';
part 'main.rsp.dart';

@RiverpodStateProvider()
int myInteger() {
  return 0;
}

@RiverpodStateProvider()
List<int> myList() {
  return const [0];
}
