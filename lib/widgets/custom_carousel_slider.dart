import 'package:anime_search/utiles/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:anime_search/model/anime.dart';
import 'package:shadow_overlay/shadow_overlay.dart';

class AnimeCarousel extends StatelessWidget {
  final List<Anime> animeList;

  const AnimeCarousel({
    Key? key,
    required this.animeList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: getDeviceHeight(context) * 0.3,
        scrollPhysics: const BouncingScrollPhysics(),
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: animeList.map((anime) {
        return Builder(
          builder: (BuildContext context) {
            return Stack(
              children: [
                ShadowOverlay(
                  shadowColor: Colors.black,
                  shadowHeight: 150,
                  shadowWidth: 900,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: getDeviceHeight(context) * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(anime.trailerThumbnail),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        anime.title,
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
            );
          },
        );
      }).toList(),
    );
  }
}
