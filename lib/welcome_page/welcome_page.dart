import 'package:flutter/material.dart';
import 'package:gitodo/constants/constant_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool showBody = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((val) {
      setState(() {
        showBody = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('backgrounds/login_bg.webp'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedPadding(
              curve: Curves.decelerate,
              padding: EdgeInsets.only(bottom: showBody ? 0 : 80),
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
                  ),
                  constraints: const BoxConstraints(maxWidth: 500),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(welcomePageString),
                      const SizedBox(
                        height: 15,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Image.asset('icons/arrow_right.png', scale: 10))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
