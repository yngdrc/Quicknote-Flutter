import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:quicknote/authentication/auth_service.dart';
import 'package:quicknote/authentication/signup_screen.dart';
import 'package:quicknote/authentication/widgets_authentication.dart';
import 'package:quicknote/colors/quicknote_colors.dart';
import 'package:quicknote/home/home_screen.dart';
import 'package:quicknote/widgets_common.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  final TextEditingController _emailAddressController = TextEditingController();

  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    restoreEmailAddress();
    super.initState();
  }

  String? _emailAddress;
  String? _password;

  Future<void> restoreEmailAddress() async {
    final prefs = await getIt.getAsync<SharedPreferences>();
    final cachedEmailAddress = prefs.getString("email");
    if (cachedEmailAddress == null) {
      return;
    }

    widget._emailAddressController.text = cachedEmailAddress;
    _emailAddress = cachedEmailAddress;
  }

  @override
  Widget build(BuildContext context) {
    final bool canLogin = (_emailAddress?.isNotEmpty ?? false) &&
        (_password?.isNotEmpty ?? false);

    onPressed() => getIt<AuthService>().signIn(
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
              controller: widget._emailAddressController,
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
            Padding(
              padding: const EdgeInsets.all(20),
              child: FilledButton(
                onPressed: canLogin ? onPressed : null,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 40),
                  backgroundColor: QuicknoteColors.blackShade2,
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
                      text: "Don't have an account?\n",
                    ),
                    TextSpan(
                      text: "create an account",
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 11,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ),
                          );
                        },
                    ),
                    const TextSpan(
                      text: " or ",
                    ),
                    TextSpan(
                      text: "continue as a guest",
                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontSize: 11,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
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
