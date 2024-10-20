import 'package:flutter/material.dart';
import 'package:quicknote/authentication/auth_service.dart';
import 'package:quicknote/authentication/signin_screen.dart';

import '../colors/quicknote_colors.dart';
import '../main.dart';

class AuthenticatedUserWidget extends StatelessWidget {
  const AuthenticatedUserWidget({super.key});

  Future<void> signOut(BuildContext context) =>
      getIt<AuthService>().signOut((_) => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SignInScreen(),
            ),
          ));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          FilledButton(
            onPressed: () => signOut(context),
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
              backgroundColor: QuicknoteColors.blackShade2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide.none,
              ),
            ),
            child: const Text("Sign out"),
          ),
        ],
      ),
    );
  }
}

class AnonymousUserWidget extends StatelessWidget {
  const AnonymousUserWidget({super.key});

  Future<void> signOut(BuildContext context) => getIt<AuthService>().signOut(
        (_) => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SignInScreen(),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          FilledButton(
            onPressed: () => signOut(context),
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 40),
              backgroundColor: QuicknoteColors.blackShade2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
                side: BorderSide.none,
              ),
            ),
            child: const Text("Sign out"),
          ),
        ],
      ),
    );
  }
}
