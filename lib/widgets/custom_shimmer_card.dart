import 'package:anime_search/utils/colors.dart';
import 'package:anime_search/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          primaryColor,
          secondaryColor,
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          width: getDeviceWidth(context) * 0.45,
          height: getDeviceHeight(context) * 0.20,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}
