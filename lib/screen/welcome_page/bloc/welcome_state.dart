part of 'welcome_bloc.dart';

class WelcomeState extends Equatable {
  final WelcomePageDisplay welcomePageDisplay;
  final bool showBody;
  final bool isProcessing;
  final WelcomePageFunction welcomePageFunction;
  final String functionMessage;
  final bool showFunctionMessage;
  final bool loginSuccessful;

  const WelcomeState({
    required this.welcomePageDisplay,
    required this.showBody,
    required this.isProcessing,
    required this.welcomePageFunction,
    required this.functionMessage,
    required this.showFunctionMessage,
    required this.loginSuccessful,
  });

  @override
  List<Object> get props => [
        welcomePageDisplay,
        showBody,
        isProcessing,
        welcomePageFunction,
        functionMessage,
        showFunctionMessage,
        loginSuccessful
      ];

  WelcomeState.initial()
      : welcomePageDisplay = WelcomePageDisplay.welcomeMessage,
        showBody = false,
        isProcessing = false,
        welcomePageFunction = WelcomePageFunction.login,
        functionMessage = '',
        showFunctionMessage = false,
        loginSuccessful = false;

  WelcomeState copyWith({
    WelcomePageDisplay? welcomePageDisplay,
    bool? showBody,
    bool? isProcessing,
    WelcomePageFunction? welcomePageFunction,
    String? functionMessage,
    bool? showFunctionMessage,
    bool? loginSuccessful,
  }) {
    return WelcomeState(
      welcomePageDisplay: welcomePageDisplay ?? this.welcomePageDisplay,
      showBody: showBody ?? this.showBody,
      isProcessing: isProcessing ?? this.isProcessing,
      welcomePageFunction: welcomePageFunction ?? this.welcomePageFunction,
      functionMessage: functionMessage ?? this.functionMessage,
      showFunctionMessage: showFunctionMessage ?? this.showFunctionMessage,
      loginSuccessful: loginSuccessful ?? this.loginSuccessful,
    );
  }
}
