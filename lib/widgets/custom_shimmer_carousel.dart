import 'package:anime_search/utils/colors.dart';
import 'package:anime_search/utils/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCarousel extends StatelessWidget {
  const ShimmerCarousel({super.key});

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
      child: CarouselSlider.builder(
        itemCount: 5, // number of shimmer cards
        options: CarouselOptions(
          height: getDeviceHeight(context) * 0.3,
          autoPlay: true,
          enlargeCenterPage: true,
        ),
        itemBuilder: (context, index, realIndex) {
          return Container(
            width: getDeviceWidth(context),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
          );
        },
      ),
    );
  }
}
