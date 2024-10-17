import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quicknote/widgets_common.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AuthenticationScreenState();
  }
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  String? emailAddress;
  String? password;

  Future<void> signIn(Function(UserCredential) onSuccess) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress!, password: password!);

      final userEmail = credential.user?.email;
      if (userEmail != null) {
        prefs.setString("email", userEmail);
      }

      onSuccess(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canLogin =
        (emailAddress?.isNotEmpty ?? false) && (password?.isNotEmpty ?? false);

    onPressed() =>
        signIn((credential) =>
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) =>
                    Text(
                      "Logged in: ${credential.user?.email}",
                    ),
              ),
            ),
        );

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _AuthenticationHeader(),
          TextInputWidget(
            label: "Email",
            hintText: "example@email.com",
            onChanged: (emailAddress) =>
                setState(() => this.emailAddress = emailAddress),
          ),
          TextInputWidget(
            label: "Password",
            hintText: "********",
            onChanged: (password) => setState(() => this.password = password),
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
        ],
      ),
    );
  }
}

class _AuthenticationHeader extends StatelessWidget {
  const _AuthenticationHeader();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Quicknote",
            style: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          Text(
            "Lorem ipsum\ndolor sit amet",
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 20),
          )
        ],
      ),
    );
  }
}
