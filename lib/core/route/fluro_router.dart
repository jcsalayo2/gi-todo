import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:gitodo/welcome_page/welcome_page.dart';

class FluroRouterClass {
  static FluroRouter fluroRouter = FluroRouter();

  static var homeScreenHandler = Handler(
      handlerFunc: ((BuildContext? context, Map<String, dynamic> params) {
    return const WelcomePage();
  }));

  static initRoutes() {
    fluroRouter.define('/', handler: homeScreenHandler);
  }
}
