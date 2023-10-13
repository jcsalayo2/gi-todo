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
