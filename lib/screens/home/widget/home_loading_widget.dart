import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lydiaryanfluttersurvey/resources/dimensions.dart';

class HomeLoadingWidget extends StatelessWidget {
  const HomeLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingMedium),
          child: Shimmer.fromColors(
            baseColor: Colors.white12,
            highlightColor: Colors.white24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildShimmer(screenWidth * 0.4),
                        const SizedBox(height: 14.0),
                        _buildShimmer(screenWidth * 0.3),
                      ],
                    ),
                    const Expanded(child: SizedBox.shrink()),
                    _buildShimmer(
                      Dimensions.userAvatarRadius,
                      height: Dimensions.userAvatarRadius,
                      borderRadius: Dimensions.userAvatarRadius / 2,
                    )
                  ],
                ),
                const Expanded(child: SizedBox.shrink()),
                _buildShimmer(screenWidth),
                const SizedBox(height: Dimensions.paddingSmallPlus),
                _buildShimmer(screenWidth * 0.7),
                const SizedBox(height: Dimensions.paddingSmall),
                _buildShimmer(screenWidth * 0.4),
                const SizedBox(height: Dimensions.paddingSmallPlus),
                _buildShimmer(screenWidth * 0.9),
                const SizedBox(height: Dimensions.paddingSmall),
                _buildShimmer(screenWidth * 0.6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmer(
    double width, {
    double height = Dimensions.homeSkeletonLoadingTextHeight,
    double borderRadius = Dimensions.homeSkeletonLoadingTextBorderRadius,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.white,
      ),
    );
  }
}
