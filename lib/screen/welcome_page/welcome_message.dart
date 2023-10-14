import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitodo/constants/constant_text.dart';
import 'package:gitodo/constants/constant_value.dart';
import 'package:gitodo/core/widgets/animated.dart';
import 'package:gitodo/screen/welcome_page/bloc/welcome_bloc.dart';
import 'package:gitodo/styles/colors.dart';

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    super.key,
    required this.state,
    required this.showBody,
    required this.isProcessing,
    required this.emailController,
    required this.passwordController,
    required this.welcomePageFunction,
  });

  final WelcomePageDisplay state;
  final bool showBody;
  final bool isProcessing;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final WelcomePageFunction welcomePageFunction;

  @override
  Widget build(BuildContext context) {
    return animatedInAndOut(
        isDisplayed: showBody,
        left: MediaQuery.of(context).size.width < 840 ? 20 : 0,
        right: MediaQuery.of(context).size.width < 840 ? 20 : 0,
        component: Align(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border.all(
                    width: 3,
                  ),
                  color: ColorStyles.whiteTransparent,
                ),
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: (() {
                    if (state == WelcomePageDisplay.welcomeMessage) {
                      return welcomeBody(context);
                    } else if (state == WelcomePageDisplay.login) {
                      return loginBody(
                        context: context,
                        isProcessing: isProcessing,
                        emailController: emailController,
                        passwordController: passwordController,
                        welcomePageFunction: welcomePageFunction,
                      );
                    } else {
                      return <Widget>[];
                    }
                  }()),
                ),
              ),
            ],
          ),
        ));
  }

  List<Widget> welcomeBody(BuildContext context) {
    return [
      Image.asset('icons/app_icon.webp', scale: 12),
      const SizedBox(
        height: 10,
      ),
      const Text(
        welcomePageString,
        maxLines: 10,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontFamily: 'Monday-Rain',
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: () {
            BlocProvider.of<WelcomeBloc>(context)
                .add(const WelcomeDisplayLoginEvent());
          },
          icon: Image.asset('icons/arrow_right.png', scale: 10),
        ),
      )
    ];
  }

  List<Widget> loginBody({
    required BuildContext context,
    required bool isProcessing,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required WelcomePageFunction welcomePageFunction,
  }) {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          welcomePageFunctionWidget(
            onTap: () {
              BlocProvider.of<WelcomeBloc>(context).add(
                const WelcomeChangeFunctionEvent(
                  welcomePageFunction: WelcomePageFunction.login,
                ),
              );
            },
            title: "Login",
            color: welcomePageFunction == WelcomePageFunction.login
                ? Theme.of(context).colorScheme.primary
                : null,
            context: context,
          ),
          const Text(
            "|",
            style: TextStyle(
              fontFamily: 'Monday-Rain',
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),
          welcomePageFunctionWidget(
            onTap: () {
              BlocProvider.of<WelcomeBloc>(context).add(
                const WelcomeChangeFunctionEvent(
                  welcomePageFunction: WelcomePageFunction.signup,
                ),
              );
            },
            title: "Signup",
            color: welcomePageFunction == WelcomePageFunction.signup
                ? Theme.of(context).colorScheme.primary
                : null,
            context: context,
          ),
        ],
      ),
      const SizedBox(
        height: 15,
      ),
      TextField(
        controller: emailController,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          hintText: "Email",
          counterText: "",
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      TextField(
        controller: passwordController,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        textAlign: TextAlign.center,
        decoration: const InputDecoration(
          hintText: "Password",
          counterText: "",
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: !isProcessing
              ? () {
                  if (emailController.text == '' ||
                      passwordController.text == '') return;
                  BlocProvider.of<WelcomeBloc>(context).add(
                      WelcomeFunctionEvent(
                          email: emailController.text,
                          password: passwordController.text));
                }
              : null,
          icon: Image.asset('icons/arrow_right.png', scale: 10),
        ),
      )
    ];
  }

  InkWell welcomePageFunctionWidget({
    required String title,
    required Color? color,
    required BuildContext context,
    required Null Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: TextStyle(
          color: color,
          fontFamily: 'Monday-Rain',
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
