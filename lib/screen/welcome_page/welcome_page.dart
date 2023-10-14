import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitodo/core/widgets/animated.dart';
import 'package:gitodo/screen/welcome_page/bloc/welcome_bloc.dart';
import 'package:gitodo/services/firebase_auth/firebase_auth.dart';
import 'package:gitodo/styles/colors.dart';

import 'welcome_message.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      Navigator.pop(context);
      Navigator.pushNamed(context, "/home");
    }
    return BlocProvider(
      create: (context) =>
          WelcomeBloc()..add(const WelcomeDisplayMessageEvent()),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('backgrounds/login_bg.webp'),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocConsumer<WelcomeBloc, WelcomeState>(
            listener: (context, state) {
              if (state.loginSuccessful) {
                Navigator.pop(context);
                Navigator.pushNamed(context, "/home");
              }
            },
            builder: (context, state) {
              return Stack(
                children: [
                  Positioned.fill(
                    child: WelcomeMessage(
                      emailController: emailController,
                      passwordController: passwordController,
                      state: state.welcomePageDisplay,
                      showBody: state.showBody,
                      isProcessing: state.isProcessing,
                      welcomePageFunction: state.welcomePageFunction,
                    ),
                  ),
                  Positioned.fill(
                    bottom: MediaQuery.of(context).size.height * 0.05,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: animatedInAndOut(
                        isDisplayed: state.showFunctionMessage,
                        component: Container(
                          margin: EdgeInsets.only(top: 30),
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(30),
                            ),
                            border: Border.all(
                              width: 3,
                            ),
                            color: ColorStyles.whiteTransparent,
                          ),
                          child: Text(
                            state.functionMessage,
                            style: const TextStyle(
                              fontFamily: 'Monday-Rain',
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state.isProcessing)
                    Positioned.fill(
                        child: Container(
                      color: const Color(0x73000000),
                      child: Align(
                        alignment: MediaQuery.of(context).size.width < 840
                            ? Alignment.bottomCenter
                            : Alignment.bottomRight,
                        child: Image.asset(
                          'loading_animations/cat_loading2.gif',
                          scale: 3,
                        ),
                      ),
                    ))
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
