import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';

import '../../../bindings/provider/userProvider.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(userProvider.notifier);
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.android,
                size: 80,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 32),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email/Phone Number',
              ),
              controller: emailController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              controller: passwordController,
            ),
            const SizedBox(height: 32),
            GFButton(
              onPressed: () {
                // Handle login here
                ref.read(userProvider.notifier).signInWithEmailAndPassword();
              },
              text: 'Login',
              color: Colors.green,
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    //Handle forgot password logic here
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle signup navigation logic here
                  },
                  child: const Text(
                    "Dont't have an account? Sign Up",
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            GFButton(
              onPressed: () {
                user.signInWithGoogle();
              },
              text: 'Login with Google',
              color: Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
