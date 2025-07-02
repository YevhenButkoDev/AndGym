import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'auth/AuthGate.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Stripe.publishableKey = "pk_test_51RKDag4FvwHfmt8y7jLvaAwZ7HFKKnuA5SVh4huzXWq073qC7KUXoPAEBFzu8G0iisuinHfLFLtygbquZCRDdz2J00OEGVXDQV";
  runApp(MyApp());
}

final darkTheme = ThemeData(
  fontFamily: 'DMSans',
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color.fromRGBO(30, 31, 36, 1.0),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromRGBO(30, 31, 36, 1.0)
  ),
  navigationBarTheme: NavigationBarThemeData(
    backgroundColor: const Color.fromRGBO(45, 45, 53, 1.0),
  ),
);


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AndGym',
      themeMode: ThemeMode.dark,
      darkTheme: darkTheme,
      home: AuthGate(),
    );
  }
}