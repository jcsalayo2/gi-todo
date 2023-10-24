part of 'home_page.dart';

abstract class HomePageEvent extends Equatable {
  const HomePageEvent();

  @override
  List<Object> get props => [];
}

class MonthlyViewComputeForMaxRowsEvent extends HomePageEvent {
  final int startOfTheWeek;
  @override
  List<Object> get props => [];

  const MonthlyViewComputeForMaxRowsEvent({
    required this.startOfTheWeek,
  });
}

class ChangeSelectedDateEvent extends HomePageEvent {
  final int date;
  @override
  List<Object> get props => [];

  const ChangeSelectedDateEvent({
    required this.date,
  });
}

class ChangeChecklistEvent extends HomePageEvent {
  @override
  List<Object> get props => [];

  const ChangeChecklistEvent();
}
