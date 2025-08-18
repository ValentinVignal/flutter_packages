import 'package:static_json_serializable_annotation/static_json_serializable_annotation.dart';

part 'const_only.g.dart';

@StaticJsonSerializable()
abstract class ConstOnlyClass {
  static const double staticConstValue1 = 1;
  static const double staticConstValue2 = 2;

  final int finalValue1 = 7;
  final int finalValue2 = 8;

  int value1 = 9;
  int value2 = 10;
}
