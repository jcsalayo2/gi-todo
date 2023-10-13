part of 'welcome_bloc.dart';

class WelcomeState extends Equatable {
  final WelcomePageDisplay welcomePageDisplay;
  final bool showBody;

  const WelcomeState({
    required this.welcomePageDisplay,
    required this.showBody,
  });

  @override
  List<Object> get props => [
        welcomePageDisplay,
        showBody,
      ];

  WelcomeState.initial()
      : welcomePageDisplay = WelcomePageDisplay.welcomeMessage,
        showBody = false;

  WelcomeState copyWith({
    WelcomePageDisplay? welcomePageDisplay,
    bool? showBody,
  }) {
    return WelcomeState(
      welcomePageDisplay: welcomePageDisplay ?? this.welcomePageDisplay,
      showBody: showBody ?? this.showBody,
    );
  }
}
