import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gitodo/screen/home_page/home_page.dart';
import 'package:gitodo/screen/welcome_page/welcome_message.dart';
import 'package:gitodo/screen/welcome_page/welcome_page.dart';
import 'package:gitodo/services/firebase_auth/firebase_auth.dart';

class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      return const WelcomePage();
    } else {
      return WillPopScope(
        onWillPop: () async => false,
        child: const HomePage(),
      );
    }
  }
}
