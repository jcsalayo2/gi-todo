import 'package:gitodo/constants/constant_value.dart';

extension MapExtension on Map {
  Map arrangeByFirstDay(int startOfWeek) {
    int index = startOfWeek;
    Map<int, String> newDays = {};
    do {
      newDays.addAll({index: days[index]!});
      index++;
      if (index > 7) {
        index = 1;
      }
    } while (index != startOfWeek);

    return newDays;
  }
}
