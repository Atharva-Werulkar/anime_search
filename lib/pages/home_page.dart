import 'package:anime_search/backend/backend.dart';
import 'package:anime_search/model/anime.dart';
import 'package:anime_search/utiles/colors.dart';
import 'package:anime_search/widgets/custom_anime_card.dart';
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
                    return CarouselSlider(
                      options: CarouselOptions(
                        height: 200.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),
                      items: snapshot.data!.map((anime) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(15.0),
                                //blur background image
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black26,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: <Widget>[
                                  Image.network(
                                    anime.trailerThumbnail,
                                    fit: BoxFit.cover,
                                    height: 150.0,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Flexible(
                                    child: Text(
                                      anime.title,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
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
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return AnimeCard(
                            trailerUrl: snapshot.data![index].trailerUrl,
                            title: snapshot.data![index].title,
                            thumbnailUrl:
                                snapshot.data![index].trailerThumbnail,
                            url: snapshot.data![index].url,
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
                      height: 200.0,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: secondaryColor,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Image.network(
                                    snapshot.data![index].trailerThumbnail,
                                    fit: BoxFit.cover,
                                    height: 100.0,
                                  ),
                                  const SizedBox(height: 10.0),
                                  Flexible(
                                    child: Text(
                                      snapshot.data![index].title,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.bold,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10.0),
                                  Text(
                                    'Release Date: ${snapshot.data![index].title}',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
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
