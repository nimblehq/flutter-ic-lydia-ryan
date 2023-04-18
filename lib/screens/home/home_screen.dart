import 'package:flutter/material.dart';
import 'package:lydiaryanfluttersurvey/screens/home/widget/home_loading_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeLoadingWidget(),
    );
  }
}
