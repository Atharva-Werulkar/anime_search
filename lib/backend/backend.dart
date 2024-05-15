import 'dart:convert';
import 'dart:developer';

import 'package:anime_search/model/anime.dart';
import 'package:http/http.dart' as http;

class Backend {
  //search anime
  static Future<List<Anime>> searchAnime(String name) async {
    final response =
        await http.get(Uri.parse('https://api.jikan.moe/v4/anime?q=$name'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      // log('fetching data from api:  $body ');

      List<Anime> animeList =
          body.map((dynamic item) => Anime.fromMap(item)).toList();

      log(' Searched Anime List Fetched');

      return animeList;
    } else {
      throw Exception('Failed to load anime');
    }
  }

  //get top anime

  static Future<List<Anime>> getTopAnime() async {
    final response =
        await http.get(Uri.parse('https://api.jikan.moe/v4/top/anime'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      List<Anime> animeList =
          body.map((dynamic item) => Anime.fromMap(item)).toList();
      log('Top Anime List Fetched ');
      return animeList;
    } else {
      throw Exception('Failed to load top anime');
    }
  }

  //get upcoming anime season
  static Future<List<Anime>> getUpcomingAnime() async {
    final response =
        await http.get(Uri.parse('https://api.jikan.moe/v4/seasons/upcoming'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['data'];
      List<Anime> animeList =
          body.map((dynamic item) => Anime.fromMap(item)).toList();
      log('Upcoming Anime List Fetched ');
      return animeList;
    } else {
      throw Exception('Failed to load upcoming anime');
    }
  }

  // //get anime recommendations
  //
  // // 'https://api.jikan.moe/v4/anime/1/recommendations'
  // //     'https://api.jikan.moe/v4/recommendations/anime'
  // static Future<List<Anime>> getAnimeRecommendations() async {
  //   final response = await http.get(
  //       Uri.parse('https://api.jikan.moe/v4/recommendations/anime?page=1'));
  //   log('Anime Recommendations Response :  $response ');
  //
  //   if (response.statusCode == 200) {
  //     List<dynamic> body = jsonDecode(response.body)['data'];
  //     List<Anime> animeList =
  //         body.map((dynamic item) => Anime.fromMap(item)).toList();
  //     log('Anime Recommendations List :  $animeList ');
  //     return animeList;
  //   } else {
  //     throw Exception('Failed to load anime recommendations');
  //   }
  // }
}
