part of 'home_page.dart';

class HomePageState extends Equatable {
  final int monthlyViewMaxRows;
  final CalendarView calendarView;
  final int displayYear;
  final int displayMonth;
  final DateTime selectedDate;
  final List<ChecklistModel> checklist;
  final DateTime dateTime; // Force Emit ONLY

  const HomePageState({
    required this.monthlyViewMaxRows,
    required this.calendarView,
    required this.displayMonth,
    required this.displayYear,
    required this.selectedDate,
    required this.checklist,
    required this.dateTime,
  });

  HomePageState.initial()
      : monthlyViewMaxRows = 0,
        calendarView = CalendarView.Monthly,
        displayMonth = DateTime.now().month,
        displayYear = DateTime.now().year,
        selectedDate = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        checklist = [],
        dateTime = DateTime.now();

  @override
  List<Object> get props => [
        monthlyViewMaxRows,
        displayMonth,
        calendarView,
        displayYear,
        selectedDate,
        checklist,
        dateTime,
      ];

  HomePageState copyWith({
    int? monthlyViewMaxRows,
    CalendarView? calendarView,
    int? displayMonth,
    int? displayYear,
    DateTime? selectedDate,
    List<ChecklistModel>? checklist,
    DateTime? dateTime,
  }) {
    return HomePageState(
      monthlyViewMaxRows: monthlyViewMaxRows ?? this.monthlyViewMaxRows,
      calendarView: calendarView ?? this.calendarView,
      displayMonth: displayMonth ?? this.displayMonth,
      displayYear: displayYear ?? this.displayYear,
      selectedDate: selectedDate ?? this.selectedDate,
      checklist: checklist ?? this.checklist,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}
