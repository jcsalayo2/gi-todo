part of 'welcome_bloc.dart';

abstract class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object> get props => [];
}

class WelcomeDisplayMessageEvent extends WelcomeEvent {
  @override
  List<Object> get props => [];

  const WelcomeDisplayMessageEvent();
}

class WelcomeDisplayLoginEvent extends WelcomeEvent {
  @override
  List<Object> get props => [];

  const WelcomeDisplayLoginEvent();
}

class WelcomeFunctionEvent extends WelcomeEvent {
  final String email;
  final String password;
  @override
  List<Object> get props => [];

  const WelcomeFunctionEvent({
    required this.email,
    required this.password,
  });
}

class WelcomeChangeFunctionEvent extends WelcomeEvent {
  final WelcomePageFunction welcomePageFunction;
  @override
  List<Object> get props => [];

  const WelcomeChangeFunctionEvent({
    required this.welcomePageFunction,
  });
}

class WelcomeHideError extends WelcomeEvent {
  @override
  List<Object> get props => [];

  const WelcomeHideError();
}
