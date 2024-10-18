import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quicknote/widgets_common.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationScreen extends StatefulWidget {
  AuthenticationScreen({super.key});

  final TextEditingController _emailAddressController = TextEditingController();

  @override
  State<StatefulWidget> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  @override
  void initState() {
    super.initState();
    restoreEmailAddress();
  }

  String? _emailAddress;
  String? _password;

  Future<void> restoreEmailAddress() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedEmailAddress = prefs.getString("email");
    if (cachedEmailAddress == null) {
      return;
    }

    widget._emailAddressController.text = cachedEmailAddress;
    _emailAddress = cachedEmailAddress;
  }

  Future<void> signInWithEmail(Function(UserCredential) onSuccess) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailAddress!, password: _password!);

      final userEmail = credential.user?.email;
      if (userEmail != null) {
        prefs.setString("email", userEmail);
      }

      onSuccess(credential);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message ?? "Sign in error: ${e.code}",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool canLogin = (_emailAddress?.isNotEmpty ?? false) &&
        (_password?.isNotEmpty ?? false);

    onPressed() => signInWithEmail(
          (credential) => Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => Text(
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
