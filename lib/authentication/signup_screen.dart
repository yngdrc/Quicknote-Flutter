import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quicknote/authentication/auth_service.dart';
import 'package:quicknote/authentication/signin_screen.dart';
import 'package:quicknote/authentication/widgets_authentication.dart';
import 'package:quicknote/home/home_screen.dart';

import '../colors/quicknote_colors.dart';
import '../main.dart';
import '../widgets_common.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String? _emailAddress;
  String? _password;
  String? _confirmPassword;

  @override
  Widget build(BuildContext context) {
    final bool canLogin = (_emailAddress?.isNotEmpty ?? false) &&
        (_password?.isNotEmpty ?? false) &&
        (_confirmPassword?.isNotEmpty ?? false) &&
        _password == _confirmPassword;

    onPressed() => getIt<AuthService>().signUp(
          emailAddress: _emailAddress,
          password: _password,
          (credential) => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          ),
        );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AuthenticationHeader(),
            TextInputWidget(
              label: "Email",
              hintText: "example@email.com",
              onChanged: (emailAddress) =>
                  setState(() => _emailAddress = emailAddress),
            ),
            TextInputWidget(
              label: "Password",
              hintText: "********",
              onChanged: (password) => setState(() => _password = password),
              obscure: true,
            ),
            TextInputWidget(
              label: "Confirm password",
              hintText: "********",
              onChanged: (password) =>
                  setState(() => _confirmPassword = password),
              obscure: true,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: FilledButton(
                onPressed: canLogin ? onPressed : null,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide.none,
                  ),
                ),
                child: const Text("Sign in"),
              ),
            ),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 11,
                  ),
                  children: [
                    const TextSpan(
                      text: "Already registered? ",
                    ),
                    TextSpan(
                      text: "Sign in",
                      style: const TextStyle(
                        color: QuicknoteColors.blackShade2,
                        fontSize: 11,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
