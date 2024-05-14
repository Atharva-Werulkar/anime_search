class Anime {
  final String id;
  final String title;
  final String url;
  final String trailerUrl;
  final String trailerThumbnail;
  final String synopsis;

  Anime({
    required this.id,
    required this.title,
    required this.url,
    required this.trailerUrl,
    required this.trailerThumbnail,
    required this.synopsis,
  });

  // Factory method to create an Anime instance from a Map
  factory Anime.fromMap(Map<String, dynamic> json) {
    return Anime(
      id: json['mal_id'].toString(),
      title: json['title_english'] != null
          ? json['title_english'].toString()
          : json['title'].toString(),
      url: json['url'].toString(),
      trailerUrl: json['trailer']['url'].toString(),
      trailerThumbnail: json['images']['jpg']['image_url'].toString(),
      synopsis: json['synopsis'].toString(),
    );
  }
  // Method to convert Anime instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'trailerUrl': trailerUrl,
      'trailerThumbnail': trailerThumbnail,
      'synopsis': synopsis,
    };
  }

  @override
  String toString() {
    return 'Anime{id: $id, title: $title, url: $url, trailerUrl: $trailerUrl, trailerThumbnail: $trailerThumbnail, synopsis: $synopsis}';
  }
}
