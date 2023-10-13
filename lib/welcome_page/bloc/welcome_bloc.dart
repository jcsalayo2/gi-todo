import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gitodo/constants/constant_value.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeState.initial()) {
    on<WelcomeEvent>((event, emit) {});
    on<WelcomeDisplayMessageEvent>(_welcomeDisplayMessageEvent);
    on<WelcomeDisplayLoginEvent>(_welcomeDisplayLoginEvent);
  }

  FutureOr<void> _welcomeDisplayMessageEvent(
      WelcomeDisplayMessageEvent event, Emitter<WelcomeState> emit) async {
    await Future.delayed(const Duration(seconds: 2)).then((val) {
      emit(state.copyWith(
        welcomePageDisplay: WelcomePageDisplay.welcomeMessage,
        showBody: true,
      ));
    });
  }

  FutureOr<void> _welcomeDisplayLoginEvent(
      WelcomeDisplayLoginEvent event, Emitter<WelcomeState> emit) async {
    emit(state.copyWith(
      showBody: false,
    ));
    await Future.delayed(const Duration(milliseconds: 750)).then((val) {
      emit(state.copyWith(
        showBody: true,
        welcomePageDisplay: WelcomePageDisplay.login,
      ));
    });
  }
}
