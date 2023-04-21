import 'package:flutter/material.dart';

class BackGroundWidget extends StatelessWidget {
  final ImageProvider image;
  final double opacity;

  const BackGroundWidget({
    Key? key,
    required this.image,
    this.opacity = 0.35,
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
    );
  }
}
