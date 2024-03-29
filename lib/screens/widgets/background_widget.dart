import 'dart:ui';

import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final ImageProvider image;
  final double opacity;
  final bool shouldBlur;
  final double blurSigma;
  final Widget? child;

  const BackgroundWidget({
    Key? key,
    required this.image,
    this.opacity = 0.35,
    this.shouldBlur = false,
    this.blurSigma = 5,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(opacity), BlendMode.darken),
        ),
      ),
      child: shouldBlur
          ? ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
                child: child,
              ),
            )
          : child,
    );
  }
}
