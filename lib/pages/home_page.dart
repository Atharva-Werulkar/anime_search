import 'package:anime_search/backend/backend.dart';
import 'package:anime_search/model/anime.dart';
import 'package:anime_search/utiles/colors.dart';
import 'package:anime_search/utiles/constants.dart';
import 'package:anime_search/widgets/custom_anime_card.dart';
import 'package:anime_search/widgets/custom_carousel_slider.dart';
import 'package:anime_search/widgets/custom_homepage_card.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Anime>>? _topAnime;
  Future<List<Anime>>? _upcomingAnime;
  // Future<List<Anime>>? _popularAnime;

  @override
  void initState() {
    super.initState();
    _topAnime = Backend.getTopAnime();
    _upcomingAnime = Backend.getUpcomingAnime();
    // _popularAnime = Backend.getAnimeRecommendations();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Spotlight',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),

              // Carousel Slider
              FutureBuilder<List<Anime>>(
                future: _topAnime,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return AnimeCarousel(animeList: snapshot.data!);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  );
                },
              ),
              const SizedBox(height: 10.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Popular Anime',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              //list of popular anime
              FutureBuilder<List<Anime>>(
                future: _topAnime,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: getDeviceHeight(context) * 0.3,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: HomePageCard(
                              trailerUrl: snapshot.data![index].trailerUrl,
                              title: snapshot.data![index].title,
                              thumbnailUrl:
                                  snapshot.data![index].trailerThumbnail,
                              url: snapshot.data![index].url,
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  );
                },
              ),

              //Popular anime list
              const SizedBox(height: 10.0),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Top Upcoming Anime',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              FutureBuilder<List<Anime>>(
                future: _upcomingAnime,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: getDeviceHeight(context) * 0.3,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: HomePageCard(
                              trailerUrl: snapshot.data![index].trailerUrl,
                              title: snapshot.data![index].title,
                              thumbnailUrl:
                                  snapshot.data![index].trailerThumbnail,
                              url: snapshot.data![index].url,
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
