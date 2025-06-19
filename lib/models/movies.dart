class Movie {
  final int id;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String bannerUrl;
  final String genre;
  final double rating;
  final int releaseYear;
  final String category;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.bannerUrl,
    required this.genre,
    required this.rating,
    required this.releaseYear,
    required this.category,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnailUrl: json['thumbnailUrl'],
      bannerUrl: json['bannerUrl'],
      genre: json['genre'],
      rating: (json['rating'] as num).toDouble(),
      releaseYear: json['releaseYear'],
      category: json['category'],
    );
  }
}
