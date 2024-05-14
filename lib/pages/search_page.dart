import 'dart:developer';

import 'package:anime_search/backend/backend.dart';
import 'package:anime_search/model/anime.dart';
import 'package:anime_search/utiles/colors.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  Future<List<Anime>>? _searchResults;

  @override
  void initState() {
    super.initState();
    _searchResults = Backend.getRandomAnime();
    _searchController.addListener(_onSearchChanged);

    log('Search Page Initialized');
    log('Search Results: $_searchResults');
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchResults = Backend.searchAnime(_searchController.text);
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
                    return const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                snapshot.data![index].title,
                                style: const TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Image.network(
                                  snapshot.data![index].trailerThumbnail),
                              const SizedBox(height: 8.0),
                              Text(
                                'URL: ${snapshot.data![index].url}',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.blue,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              Text(
                                'Trailer URL: ${snapshot.data![index].trailerUrl}',
                                style: const TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  // By default, show a loading spinner.
                  return CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
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
