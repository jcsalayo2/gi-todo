import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gitodo/constants/constant_value.dart';
import 'package:gitodo/core/extensions/datetime.dart';
import 'package:gitodo/core/extensions/int.dart';
import 'package:gitodo/models/checklist_model.dart';
import 'package:gitodo/services/checklist_service.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageState.initial()) {
    on<HomePageEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<MonthlyViewComputeForMaxRowsEvent>(_monthlyViewComputeForMaxRowsEvent);
    on<ChangeSelectedDateEvent>(_changeSelectedDate);
    on<ChangeChecklistEvent>(_changeChecklistEvent);
    on<AddTaskEvent>(_addTask);
    on<MarkAsDoneEvent>(_markAsDone);
  }

  FutureOr<void> _monthlyViewComputeForMaxRowsEvent(
      MonthlyViewComputeForMaxRowsEvent event,
      Emitter<HomePageState> emit) async {
    var endOfWeek = event.startOfTheWeek.lastDayOfWeek;

    final selectedLastDate =
        DateTime(state.displayYear, state.displayMonth).lastDateOfMonth;

    int maxRows = 0;
    int lastDateOfEndOfWeek = 0;

    for (int i = 1; i <= selectedLastDate.day; i++) {
      if (DateTime(state.displayYear, state.displayMonth, i).weekday ==
          endOfWeek) {
        maxRows++;
        lastDateOfEndOfWeek =
            DateTime(state.displayYear, state.displayMonth, i).day;
      }
    }

    if (lastDateOfEndOfWeek < selectedLastDate.day) {
      maxRows++;
    }

    emit(state.copyWith(
      monthlyViewMaxRows: maxRows,
    ));
  }

  FutureOr<void> _changeSelectedDate(
      ChangeSelectedDateEvent event, Emitter<HomePageState> emit) async {
    add(ChangeChecklistEvent());
    emit(state.copyWith(
        selectedDate:
            DateTime(state.displayYear, state.displayMonth, event.date)));
  }

  FutureOr<void> _changeChecklistEvent(
      ChangeChecklistEvent event, Emitter<HomePageState> emit) async {
    var checklist = await ChecklistService().fetchChecklistByDate(
        date: DateTime(
            state.displayYear, state.displayMonth, state.selectedDate.day));

    emit(state.copyWith(checklist: checklist));
  }

  FutureOr<void> _addTask(
      AddTaskEvent event, Emitter<HomePageState> emit) async {
    var checklist =
        await ChecklistService().addTask(date: event.date, task: event.task);

    if (checklist) {
      add(ChangeChecklistEvent());
    }
  }

  FutureOr<void> _markAsDone(
      MarkAsDoneEvent event, Emitter<HomePageState> emit) async {
    ChecklistService().markAsDone(id: event.id);

    state.checklist.where((element) => element.id == event.id).first.isDone =
        true;

    emit(state.copyWith(dateTime: DateTime.now()));
  }
}
