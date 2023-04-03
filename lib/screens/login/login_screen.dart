import 'package:lydiaryanfluttersurvey/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lydiaryanfluttersurvey/screens/login/login_form_widgets.dart';

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
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 24, top: 109),
                child: LoginForm(
                  key: LoginKey.lfLoginEmail,
                  hintText: 'Email',
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 24, right: 24, top: 20),
                child: LoginForm(
                  key: LoginKey.lfLoginPassword,
                  hintText: 'Password',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
