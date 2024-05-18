import 'dart:convert';
import 'dart:developer';
import 'package:anime_search/model/anime.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Backend {
  static Future<void> saveDataToCache(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    log('Data saved to cache with key: $key');
  }

  static Future<String?> readDataFromCache(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString(key);
    if (data != null) {
      log('Data read from cache with key: $key');
    } else {
      log('No data found in cache with key: $key');
    }
    return data;
  }

  static Future<List<Anime>> fetchAnimeData(String key, String url) async {
    log('Fetching anime data with key: $key');
    String? data = await readDataFromCache(key);
    if (data == null) {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        data = response.body;
        await saveDataToCache(key, data);
        log('Data fetched from API and saved to cache with key: $key');
      } else {
        throw Exception('Failed to load anime');
      }
    }
    List<dynamic> body = jsonDecode(data)['data'];
    return body.map((dynamic item) => Anime.fromMap(item)).toList();
  }

  static Future<List<Anime>> searchAnime(String name) async {
    log('Searching anime with name: $name');
    return fetchAnimeData(
        'anime_search_$name', 'https://api.jikan.moe/v4/anime?q=$name');
  }

  static Future<List<Anime>> getTopAnime() async {
    log('Fetching top anime');
    return fetchAnimeData('top_anime', 'https://api.jikan.moe/v4/top/anime');
  }

  static Future<List<Anime>> getUpcomingAnime() async {
    log('Fetching upcoming anime');
    return fetchAnimeData(
        'upcoming_anime', 'https://api.jikan.moe/v4/seasons/upcoming');
  }
}
