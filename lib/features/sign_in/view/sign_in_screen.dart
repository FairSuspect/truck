import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truck/features/shared/view/buttons/primary_button.dart';
import 'package:truck/features/sign_in/provider/provider.dart';

import 'logo.dart';
import 'text_field.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);

  static const String routeName = 'auth';
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
              const SizedBox(height: 66),
              const Align(
                  alignment: Alignment.centerLeft, child: Text("Log in")),
              const SizedBox(height: 32),
              OutlinedTextField(
                onChanged: Provider.of<SignInProvider>(context, listen: false)
                    .onDriverIdChanged,
                label: "Driver #",
              ),
              const SizedBox(height: 36),
              OutlinedTextField(
                onChanged: Provider.of<SignInProvider>(context, listen: false)
                    .onTruckIdChanged,
                label: "Truck #",
              ),
              const Spacer(),
              Consumer<SignInProvider>(
                builder: (context, controller, child) {
                  return PrimaryButton(
                    onPressed: controller.onLogInPressed,
                    child: child!,
                  );
                },
                child: const Text("Log in"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
