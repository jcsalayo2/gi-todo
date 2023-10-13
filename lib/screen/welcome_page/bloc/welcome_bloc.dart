import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gitodo/constants/constant_value.dart';
import 'package:gitodo/services/firebase_auth/firebase_auth.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  WelcomeBloc() : super(WelcomeState.initial()) {
    on<WelcomeEvent>((event, emit) {});
    on<WelcomeDisplayMessageEvent>(_welcomeDisplayMessageEvent);
    on<WelcomeDisplayLoginEvent>(_welcomeDisplayLoginEvent);
    on<WelcomeFunctionEvent>(_welcomeFunctionEvent);
    on<WelcomeChangeFunctionEvent>(_welcomeChangeFunctionEvent);
    on<WelcomeHideError>(_welcomeHideError, transformer: restartable());
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

  FutureOr<void> _welcomeFunctionEvent(
      WelcomeFunctionEvent event, Emitter<WelcomeState> emit) async {
    emit(state.copyWith(isProcessing: true));
    if (state.welcomePageFunction == WelcomePageFunction.login) {
      var result = await FirebaseAuthService(FirebaseAuth.instance)
          .logIn(email: event.email, password: event.password);

      if (result == true) {
        emit(state.copyWith(
          loginSuccessful: true,
        ));
      } else {
        emit(state.copyWith(
          showFunctionMessage: true,
          functionMessage: result,
        ));

        add(const WelcomeHideError());
      }

      emit(state.copyWith(
        isProcessing: false,
      ));
    } else {
      var result = await FirebaseAuthService(FirebaseAuth.instance)
          .signUp(email: event.email, password: event.password);

      if (result == true) {
        emit(state.copyWith(
          showFunctionMessage: true,
          functionMessage: "Welcome aboard! 🎉",
          welcomePageFunction: WelcomePageFunction.login,
        ));
        add(const WelcomeHideError());
      } else {
        emit(state.copyWith(
          showFunctionMessage: true,
          functionMessage: result,
        ));

        add(const WelcomeHideError());
      }
      emit(state.copyWith(
        isProcessing: false,
      ));
    }
  }

  FutureOr<void> _welcomeChangeFunctionEvent(
      WelcomeChangeFunctionEvent event, Emitter<WelcomeState> emit) async {
    emit(state.copyWith(welcomePageFunction: event.welcomePageFunction));
  }

  FutureOr<void> _welcomeHideError(
      WelcomeHideError event, Emitter<WelcomeState> emit) async {
    await Future.delayed(const Duration(milliseconds: 2000)).then((val) {
      emit(state.copyWith(
        showFunctionMessage: false,
      ));
    });
  }
}
