import 'package:anime_search/backend/backend.dart';
import 'package:anime_search/model/anime.dart';
import 'package:anime_search/utils/colors.dart';
import 'package:anime_search/widgets/custom_anime_card.dart';
import 'package:anime_search/widgets/custom_shimmer_card.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<Anime>>? _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = Backend.getUpcomingAnime();

    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      if (_searchController.text.isEmpty) {
        _searchResults = Backend.getUpcomingAnime();
      } else {
        _searchResults = Backend.searchAnime(_searchController.text);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 10.0),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: secondaryColor,
                ),
                child: TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: primaryIconColor,
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search Anime',
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              FutureBuilder<List<Anime>>(
                future: _searchResults,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of grids
                        childAspectRatio: 2 / 3, // Adjust this value as needed
                      ),
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: ShimmerCard(),
                        );
                      },
                    );
                  } else if (snapshot.hasData) {
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of grids
                        childAspectRatio: 2 / 3, // Adjust this value as needed
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: AnimeCard(
                            title: snapshot.data![index].title,
                            thumbnailUrl:
                                snapshot.data![index].trailerThumbnail,
                            url: snapshot.data![index].url,
                            trailerUrl: snapshot.data![index].trailerUrl,
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a text message
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of grids
                      childAspectRatio: 2 / 3, // Adjust this value as needed
                    ),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const ShimmerCard();
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
