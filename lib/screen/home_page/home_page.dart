import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gitodo/services/firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    return Scaffold(
      body: Center(
        child: Container(
          child: Text("Welcome ${auth.currentUser?.email ?? ''}"),
        ),
      ),
    );
  }
}
