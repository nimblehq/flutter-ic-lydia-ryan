import 'package:lydiaryanfluttersurvey/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lydiaryanfluttersurvey/screens/login/login_input_widget.dart';

import 'login_keys.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.images.bgLogin.path),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                Assets.images.nimbleLogoWhite,
              ),
              const SizedBox(height: 109),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: LoginInputWidget(
                  key: LoginKey.liLoginEmail,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: LoginInputWidget(
                  key: LoginKey.liLoginPassword,
                  hintText: 'Password',
                  keyboardType: TextInputType.visiblePassword,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // TODO: Navigate to Second Screen
                },
                child: const Text("Login"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
