import 'package:riverpod_state_provider_annotation/riverpod_state_provider_annotation.dart';

part 'list.g.dart';
part 'list.rsp.dart';

@RiverpodStateProvider()
List<int> myList() {
  return const [0];
}
