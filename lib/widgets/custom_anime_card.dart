import 'package:anime_search/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shadow_overlay/shadow_overlay.dart';

class AnimeCard extends StatelessWidget {
  final String title;
  final String thumbnailUrl;
  final String url;
  final String trailerUrl;

  const AnimeCard({
    super.key,
    required this.title,
    required this.thumbnailUrl,
    required this.url,
    required this.trailerUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getDeviceHeight(context) * 0.2,
      child: Stack(
        children: [
          ShadowOverlay(
            shadowColor: Colors.black,
            shadowWidth: MediaQuery.of(context).size.width,
            shadowHeight: 150,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(thumbnailUrl),
                  fit: BoxFit.fitHeight,
                ),
              ),
              // Anime Rating At top left
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                alignment: Alignment.bottomCenter,
                child: Text(
                  title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
