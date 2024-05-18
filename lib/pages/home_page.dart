import 'package:anime_search/backend/backend.dart';
import 'package:anime_search/model/anime.dart';
import 'package:anime_search/pages/detail_page.dart';
import 'package:anime_search/utils/colors.dart';
import 'package:anime_search/utils/constants.dart';
import 'package:anime_search/widgets/custom_carousel_slider.dart';
import 'package:anime_search/widgets/custom_homepage_card.dart';
import 'package:anime_search/widgets/custom_shimmer_card.dart';
import 'package:anime_search/widgets/custom_shimmer_carousel.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Anime>>? _topAnime;
  Future<List<Anime>>? _upcomingAnime;

  @override
  void initState() {
    super.initState();
    _topAnime = Backend.getTopAnime();
    _upcomingAnime = Backend.getUpcomingAnime();
  }

  Widget buildAnimeList(
      Future<List<Anime>>? animeList, Widget Function(Anime) buildItem) {
    return FutureBuilder<List<Anime>>(
      future: animeList,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DetailPage(anime: snapshot.data![index]),
                    ),
                  );
                },
                child: buildItem(snapshot.data![index])),
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        // By default, show a shimmer loader.
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: ShimmerCard(),
          ),
        );
      },
    );
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
              const SizedBox(height: 15.0),

              // Carousel Slider
              FutureBuilder<List<Anime>>(
                future: _topAnime,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SizedBox(
                        height: getDeviceHeight(context) * 0.25,
                        width: double.infinity,
                        child: AnimeCarousel(animeList: snapshot.data!));
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  // By default, show a shimmer loader.
                  return const ShimmerCarousel();
                },
              ),

              //=====Popular anime =====//
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
              SizedBox(
                height: getDeviceHeight(context) * 0.3,
                child: buildAnimeList(
                  _topAnime,
                  (anime) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: HomePageCard(
                      trailerUrl: anime.trailerUrl ?? 'Not Available',
                      title: anime.title,
                      thumbnailUrl: anime.trailerThumbnail,
                      url: anime.url,
                    ),
                  ),
                ),
              ),

              //=====Top Upcoming anime =====//
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

              //====List of upcoming anime =====//
              SizedBox(
                height: getDeviceHeight(context) * 0.3,
                child: buildAnimeList(
                  _upcomingAnime,
                  (anime) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: HomePageCard(
                      trailerUrl: anime.trailerUrl ?? 'Not Available',
                      title: anime.title,
                      thumbnailUrl: anime.trailerThumbnail,
                      url: anime.url,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
