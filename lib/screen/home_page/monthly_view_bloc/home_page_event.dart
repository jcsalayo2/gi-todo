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

class AddTaskEvent extends HomePageEvent {
  final DateTime date;
  final String task;
  @override
  List<Object> get props => [];

  const AddTaskEvent({required this.date, required this.task});
}

class MarkAsDoneEvent extends HomePageEvent {
  final String id;
  @override
  List<Object> get props => [];

  const MarkAsDoneEvent({
    required this.id,
  });
}
