import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:module_gym/pages/redesign/MainPage.dart';
import 'package:module_gym/pages/LoginPage.dart';

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else if (snapshot.hasData) {
          return MainPage(); // User is logged in
        } else {
          return LoginPage(); // User is NOT logged in
        }
      },
    );
  }
}