import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quicknote/authentication/auth_service.dart';
import 'package:quicknote/main.dart';
import 'package:quicknote/navigation/navigation_screen.dart';
import 'package:quicknote/settings/widgets_settings.dart';
import 'package:rxdart/rxdart.dart';

class SettingsScreen extends StatelessWidget implements NavigationScreen {
  SettingsScreen({super.key});

  @override
  final Destination destination = Destination.settings;

  @override
  final PublishSubject<bool> operationRelay = PublishSubject();

  AsyncWidgetBuilder<User?> get builder =>
      (BuildContext context, AsyncSnapshot<User?> snapshot) {
        operationRelay.add(!snapshot.hasData && !snapshot.hasError);
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
    return FutureBuilder(
      future: _emailAddress,
      builder: builder,
    );
  }
}
