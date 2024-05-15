// ignore_for_file: file_names

import 'package:anime_search/utils/colors.dart';
import 'package:anime_search/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shadow_overlay/shadow_overlay.dart';

class ImageBanner extends StatelessWidget {
  final String trailerThumbnail;
  final String title;

  const ImageBanner({
    required this.trailerThumbnail,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ShadowOverlay(
          shadowHeight: 250,
          shadowWidth: getDeviceWidth(context),
          shadowColor: Colors.black.withOpacity(0.5),
          child: Image.network(
            trailerThumbnail,
            fit: BoxFit.cover,
            height: getDeviceHeight(context) * 0.5,
            width: double.infinity,
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 400,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: const Alignment(0.0, 0.4),
                begin: const Alignment(0.0, -1),
                colors: <Color>[
                  const Color(0x8A000000),
                  Colors.black12.withOpacity(0.0)
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          left: 10,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),

        // center column for the title and subtitle and play and add to list buttons
        Positioned(
          bottom: 20,
          left: 40,
          right: 20,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                title,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.play_arrow, color: textColor),
                    label: const Text('Play Trailer',
                        style: TextStyle(color: textColor)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryIconColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
