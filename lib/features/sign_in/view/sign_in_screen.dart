import 'package:flutter/material.dart';
import 'package:truck/features/shared/view/primary_button.dart';

import 'logo.dart';
import 'text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16.0, 34.0, 16.0, 58.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Logo(),
              SizedBox(height: 66),
              const Align(
                  alignment: Alignment.centerLeft, child: Text("Log in")),
              SizedBox(height: 32),
              const OutlinedTextField(
                label: "Driver #",
              ),
              SizedBox(height: 36),
              const OutlinedTextField(
                label: "Truck #",
              ),
              const Spacer(),
              PrimaryButton(
                child: const Text("Log in"),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
