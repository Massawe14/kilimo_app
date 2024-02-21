import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:getwidget/getwidget.dart';

import '../../../bindings/provider/userProvider.dart';
import '../../../util/constants/enums.dart';

class SignUpScreen extends ConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final fullNameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    
    var userType = [
      'farmer',
      'fieldExpert',
      'extensionOfficer',
    ];
  
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Full Name',
              ),
              controller: fullNameController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              controller: emailController,
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Phone Number',
              ),
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Select user type',
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      onChanged: (newValue) {
                        // Handle dropdown selection
                        if (newValue == 'Farmer') {
                          user.type = UserType.farmer;
                        } else if (newValue == 'Field Expert') {
                          user.type = UserType.fieldExpert;
                        } else if (newValue == 'Extension Officer') {
                          user.type = UserType.extensionOfficer;
                        }
                      },
                      items: userType.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              controller: passwordController,
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Confirm Password',
              ),
              obscureText: true,
              controller: confirmPasswordController,
            ),
            const SizedBox(height: 32),
            GFButton(
              onPressed: () => {
                // Handle signup logic here
                ref.read(userProvider.notifier).signUp(),
              },
              text: 'Sign Up',
              color: Colors.green,
            ),
          ],
        )
      ),
    );
  }
}
