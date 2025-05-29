import 'package:static_json_serializable_annotation/static_json_serializable_annotation.dart';

part 'integration.g.dart';

@StaticJsonSerializable()
abstract class IntClass {
  static const int staticConstValue1 = 1;
  static const int staticConstValue2 = 2;

  static final int staticFinalValue1 = 3;
  static final int staticFinalValue2 = 4;

  static int staticValue1 = 5;
  static int staticValue2 = 6;

  final int finalValue1 = 7;
  final int finalValue2 = 8;

  int value1 = 9;
  int value2 = 10;
}
