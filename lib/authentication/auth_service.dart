import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

abstract class AuthService {
  Future<User?> getCurrentUser();

  Future<void> signIn(Function(UserCredential) onSuccess,
      {required emailAddress, required password});

  Future<void> signUp(Function(UserCredential) onSuccess,
      {required emailAddress, required password});
}

@Singleton(as: AuthService)
class AuthServiceImpl implements AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<User?> getCurrentUser() async => _firebaseAuth.currentUser;

  @override
  Future<void> signIn(Function(UserCredential) onSuccess,
      {required emailAddress, required password}) async {
    try {
      final credential = await _firebaseAuth.signInWithEmailAndPassword(
          email: emailAddress, password: password);

      final userEmail = credential.user?.email;
      if (userEmail != null) {
        final prefs = await getIt.getAsync<SharedPreferences>();
        prefs.setString("email", userEmail);
      }

      onSuccess(credential);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message ?? "Sign in error: ${e.code}",
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.deepPurple,
          textColor: Colors.white);
    }
  }

  @override
  Future<void> signUp(Function(UserCredential) onSuccess,
      {required emailAddress, required password}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: emailAddress, password: password);

      Fluttertoast.showToast(
        msg: "Account created successfully",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white,
      );

      final userEmail = credential.user?.email;
      if (userEmail != null) {
        final prefs = await getIt.getAsync<SharedPreferences>();
        prefs.setString("email", userEmail);
      }

      onSuccess(credential);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message ?? "Sign up error: ${e.code}",
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.deepPurple,
        textColor: Colors.white,
      );
    }
  }
}
