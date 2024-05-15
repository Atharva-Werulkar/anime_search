import 'package:anime_search/utils/constants.dart';
import 'package:flutter/material.dart';

class HomePageCard extends StatelessWidget {
  final String title;
  final String thumbnailUrl;
  final String url;
  final String trailerUrl;

  const HomePageCard({
    super.key,
    required this.title,
    required this.thumbnailUrl,
    required this.url,
    required this.trailerUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getDeviceWidth(context) * 0.45, // Adjust this value as needed
      height: getDeviceHeight(context) * 0.20, // Adjust this value as needed
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(thumbnailUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height:
              getDeviceHeight(context) * 0.06, // Adjust this value as needed
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
