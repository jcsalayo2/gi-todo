import 'package:gitodo/constants/constant_value.dart';

extension TntExtension on int {
  int get lastDayOfWeek => this == 1 ? 7 : this - 1;

  String get weekDayString {
    if (this > 7 || this < 1) {
      throw (ArgumentError);
    }
    return days[this]!;
  }
}
