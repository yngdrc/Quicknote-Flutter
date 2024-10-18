import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quicknote/authentication/authentication_screen.dart';

import 'firebase_options.dart';

void main() {
  runApp(const QuicknoteApp());
}

Future<void> initializeFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class QuicknoteApp extends StatelessWidget {
  const QuicknoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    initializeFirebase();
    return MaterialApp(
      title: 'Quicknote',
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: AuthenticationScreen(),
      ),
    );
  }
}
