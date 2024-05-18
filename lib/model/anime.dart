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

  factory Anime.fromMap(Map<String, dynamic> json) {
    return Anime(
      id: json['mal_id'].toString(),
      title: json['title_english'] ?? json['title'].toString(),
      url: json['url'].toString(),
      trailerUrl: json['trailer']['url']?.toString(),
      trailerThumbnail: json['images']['jpg']['image_url'].toString(),
      synopsis: json['synopsis'].toString(),
      status: json['status'].toString(),
      episodes: json['episodes'].toString(),
      rating: json['score'].toString(),
      genres: List<String>.from(
          json['genres'].map((genre) => genre['name'].toString())),
      startDate:
          '${json['aired']['prop']['from']['day']}-${json['aired']['prop']['from']['month']}-${json['aired']['prop']['from']['year']}',
      endDate:
          '${json['aired']['prop']['to']['day']}-${json['aired']['prop']['to']['month']}-${json['aired']['prop']['to']['year']}',
    );
  }
}
