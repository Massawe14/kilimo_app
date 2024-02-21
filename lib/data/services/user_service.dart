import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../util/constants/enums.dart';
import '../models/userModal.dart';

// UserStateNotifier extends Notifier
class UserService extends StateNotifier<UserModal> {
  UserService(read) : super(UserModal(
    name: '',
    phone: '',
    email: '', 
    type: UserType.farmer,
    password: '',
    confirmPassword: '',
  ));

  Future<void> signUp() async {
    if (!validateFields()) {
      return;
    }

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: state.email, password: state.password);
      debugPrint('User signed up: ${userCredential.user?.email}');
      // Add further logic as needed
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed to sign up: $e');
      // Handle errors
    }
  }

  bool validateFields() {
    if (state.name.isEmpty ||
        state.email.isEmpty ||
        state.phone.isEmpty ||
        state.password.isEmpty ||
        state.confirmPassword.isEmpty) {
      debugPrint('All fields are required.');
      return false;
    }

    if (state.password != state.confirmPassword) {
      debugPrint('Passwords do not match.');
      return false;
    }

    // Add more validation as needed

    return true;
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      debugPrint('User signed in with email and password: ${state.email}');
      // Add further logic as needed
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed to sign in with email and password: $e');
      // Handle errors
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      debugPrint('User signed in with Google account');
      // Add further logic as needed
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed to sign in with Google account: $e');
      // Handle errors
    }
  }

  Future<void> sendPasswordResetEmail() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: state.email);
      debugPrint('Password reset email sent to: ${state.email}');
      // Add further logic as needed
    } on FirebaseAuthException catch (e) {
      debugPrint('Failed to send password reset email: $e');
      // Handle errors
    }
  }
}
