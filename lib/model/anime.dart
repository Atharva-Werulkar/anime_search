class Anime {
  final String id;
  final String title;
  final String url;
  final String? trailerUrl;
  final String trailerThumbnail;
  final String synopsis;
  final String status;
  final String episodes;
  final String rating;

  final List<String> genres;
  final String startDate;
  final String endDate;

  Anime({
    required this.id,
    required this.title,
    required this.url,
    this.trailerUrl,
    required this.trailerThumbnail,
    required this.synopsis,
    required this.status,
    required this.episodes,
    required this.rating,
    required this.genres,
    required this.startDate,
    required this.endDate,
  });

  static String formatDate(Map<String, dynamic> date) {
    return '${date['day']}-${date['month']}-${date['year']}';
  }

  // Factory method to create an Anime instance from a Map
  factory Anime.fromMap(Map<String, dynamic> json) {
    return Anime(
      id: json['mal_id'].toString(),
      title: json['title_english'] != null
          ? json['title_english'].toString()
          : json['title'].toString(),
      url: json['url'].toString(),
      trailerUrl: json['trailer']['url'] != null
          ? json['trailer']['url'].toString()
          : null,
      trailerThumbnail: json['images']['jpg']['image_url'].toString(),
      synopsis: json['synopsis'].toString(),
      status: json['status'].toString(),
      episodes: json['episodes'].toString(),
      rating: json['score'].toString(),
      genres: List<String>.from(
          json['genres'].map((genre) => genre['name'].toString())),
      startDate: formatDate(json['aired']['prop']['from']),
      endDate: formatDate(json['aired']['prop']['to']),
    );
  }
}
