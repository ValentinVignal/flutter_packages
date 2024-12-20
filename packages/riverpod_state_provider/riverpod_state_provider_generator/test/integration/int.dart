import 'package:riverpod_state_provider_annotation/riverpod_state_provider_annotation.dart';

part 'int.g.dart';
part 'int.rsp.dart';

@RiverpodStateProvider()
int myInteger() {
  return 0;
}
