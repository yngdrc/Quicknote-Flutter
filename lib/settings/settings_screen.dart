import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quicknote/authentication/auth_service.dart';
import 'package:quicknote/main.dart';
import 'package:quicknote/navigation/navigation_screen.dart';
import 'package:quicknote/settings/widgets_settings.dart';

class SettingsScreen extends StatelessWidget implements NavigationScreen {
  SettingsScreen({super.key});

  @override
  final Destination destination = Destination.settings;

  AsyncWidgetBuilder<User?> get builder =>
      (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.data?.isAnonymous == false) {
          return const AuthenticatedUserWidget();
        } else if (snapshot.data?.isAnonymous == true) {
          return const AnonymousUserWidget();
        } else {
          return const Text("Error");
        }
      };

  final Future<User?> _emailAddress = getIt<AuthService>().getCurrentUser();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: FutureBuilder(
        future: _emailAddress,
        builder: builder,
      ),
    );
  }
}
