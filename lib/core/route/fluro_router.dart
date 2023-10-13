import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:gitodo/screen/base_page/base_page.dart';
import 'package:gitodo/screen/home_page/home_page.dart';
import 'package:gitodo/screen/welcome_page/welcome_page.dart';

class FluroRouterClass {
  static FluroRouter fluroRouter = FluroRouter();

  static var basePageHandler = Handler(
      handlerFunc: ((BuildContext? context, Map<String, dynamic> params) {
    return const BasePage();
  }));

  static var welcomePageHandler = Handler(
      handlerFunc: ((BuildContext? context, Map<String, dynamic> params) {
    return const WelcomePage();
  }));

  static var homePageHandler = Handler(
      handlerFunc: ((BuildContext? context, Map<String, dynamic> params) {
    // Firebase Authentication instance
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return const HomePage();
    } else {
      return const WelcomePage();
    }
  }));

  static initRoutes() {
    fluroRouter.define('/login', handler: welcomePageHandler);
    fluroRouter.define('/home', handler: homePageHandler);
    fluroRouter.define('/', handler: basePageHandler);
  }
}
