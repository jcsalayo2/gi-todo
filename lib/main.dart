import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gitodo/core/route/fluro_router.dart';
import 'firebase_options.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FluroRouterClass.initRoutes();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GI Todo',
      initialRoute: "/",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xffd87a51)),
        useMaterial3: true,
      ),
      onGenerateRoute: FluroRouterClass.fluroRouter.generator,
    );
  }
}
