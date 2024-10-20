import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:quicknote/authentication/auth_service.dart';
import 'package:quicknote/authentication/signin_screen.dart';
import 'package:quicknote/main.config.dart';

import 'firebase_options.dart';
import 'home/home_screen.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() => getIt.init();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  configureDependencies();
  runApp(QuicknoteApp(await getStartPage()));
}

Future<Widget> getStartPage() async {
  final currentUser = await getIt<AuthService>().getCurrentUser();
  return currentUser == null ? const SignInScreen() : const HomeScreen();
}

class QuicknoteApp extends StatelessWidget {
  const QuicknoteApp(this._startPage, {super.key});
  final Widget _startPage;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quicknote',
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _startPage,
    );
  }
}
