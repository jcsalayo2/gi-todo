import 'package:flutter/material.dart';
import 'package:gitodo/constants/constant_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gitodo/constants/constant_value.dart';
import 'package:gitodo/welcome_page/bloc/welcome_bloc.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: BlocBuilder<WelcomeBloc, WelcomeState>(
            builder: (context, state) {
              return WelcomeMessage(
                state: state.welcomePageDisplay,
                showBody: state.showBody,
              );
            },
          ),
        ),
      ),
    );
  }
}

class WelcomeMessage extends StatelessWidget {
  const WelcomeMessage({
    super.key,
    required this.state,
    required this.showBody,
  });

  final WelcomePageDisplay state;
  final bool showBody;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedPadding(
          curve: Curves.decelerate,
          padding: EdgeInsets.only(
              bottom: showBody ? 0 : 80,
              left: MediaQuery.of(context).size.width < 840 ? 20 : 0,
              right: MediaQuery.of(context).size.width < 840 ? 20 : 0),
          duration: const Duration(milliseconds: 250),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: showBody ? 1 : 0,
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(30),
                  ),
                  border: Border.all(
                    width: 3,
                  ),
                  color: const Color(0x88FFFFFF)),
              constraints: const BoxConstraints(maxWidth: 500),
              child: Column(
                children: (() {
                  if (state == WelcomePageDisplay.welcomeMessage) {
                    return welcomeBody(context);
                  } else if (state == WelcomePageDisplay.login) {
                    return loginBody(context);
                  } else {
                    return <Widget>[];
                  }
                }()),
              ),
            ),
          ),
        )
      ],
    );
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

  List<Widget> loginBody(BuildContext context) {
    return <Widget>[
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
}
