import 'package:anime_search/backend/backend.dart';
import 'package:anime_search/model/anime.dart';

import 'package:anime_search/pages/detail_page.dart';
import 'package:anime_search/utils/colors.dart';
import 'package:anime_search/widgets/custom_anime_card.dart';
import 'package:anime_search/widgets/custom_shimmer_card.dart';
import 'package:flutter/material.dart';

// This is the main SearchPage widget.
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  // Creates the mutable state for this widget.
  @override
  SearchPageState createState() => SearchPageState();
}

// This is the private State class that goes with SearchPage.
class SearchPageState extends State<SearchPage> {
  // Controller for the search text field.
  final _searchController = TextEditingController();
  // Future that holds the search results.
  late Future<List<Anime>> _searchResults;

  @override
  void initState() {
    super.initState();
    // Initialize the search results with upcoming anime.
    _searchResults = Backend.getUpcomingAnime();
    // Add a listener to the search controller.
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    // Remove the listener from the search controller.
    _searchController.removeListener(_onSearchChanged);
    // Dispose of the search controller.
    _searchController.dispose();
    super.dispose();
  }

  // Called when the search text changes.
  void _onSearchChanged() {
    setState(() {
      // If the search text is empty, get the upcoming anime.
      // Otherwise, search for anime with the search text.
      _searchResults = _searchController.text.isEmpty
          ? Backend.getUpcomingAnime()
          : Backend.searchAnime(_searchController.text);
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
              // Build the search box.
              _buildSearchBox(),
              const SizedBox(height: 20.0),
              // Build the anime grid.
              _buildAnimeGrid(),
            ],
          ),
        ),
      ),
    );
  }

  // Builds the search box.
  Widget _buildSearchBox() {
    return Container(
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
    );
  }

  // Builds the anime grid.
  Widget _buildAnimeGrid() {
    return FutureBuilder<List<Anime>>(
      future: _searchResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the future is still running, show a loading grid.
          return _buildLoadingGrid();
        } else if (snapshot.hasError) {
          // If the future completed with an error, show an error text.
          return Text('${snapshot.error}');
        } else if (snapshot.hasData) {
          // If the future completed with data, show a data grid.
          return _buildDataGrid(snapshot.data!);
        } else {
          // Otherwise, show an empty box.
          return const SizedBox.shrink();
        }
      },
    );
  }

  // Builds the loading grid.
  Widget _buildLoadingGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
      ),
      itemCount: 10,
      itemBuilder: (context, index) => const Padding(
        padding: EdgeInsets.all(10.0),
        child: ShimmerCard(),
      ),
    );
  }

  // Builds the data grid.
  Widget _buildDataGrid(List<Anime> data) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
      ),
      itemCount: data.length,
      itemBuilder: (context, index) => _buildAnimeCard(data[index]),
    );
  }

  // Builds an anime card.
  Widget _buildAnimeCard(Anime anime) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GestureDetector(
        onTap: () {
          // Navigate to the detail page when the card is tapped.
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(anime: anime),
            ),
          );
        },
        child: AnimeCard(
          title: anime.title,
          thumbnailUrl: anime.trailerThumbnail,
          url: anime.url,
          trailerUrl: anime.trailerUrl ?? 'Not Available',
        ),
      ),
    );
  }
}
