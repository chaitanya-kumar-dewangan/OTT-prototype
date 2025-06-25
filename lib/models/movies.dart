// class StarCast {
//   final String name;
//   final String role;
//
//   StarCast({
//     required this.name,
//     required this.role,
//   });
//
//   factory StarCast.fromJson(Map<String, dynamic> json) {
//     return StarCast(
//       name: json['name'],
//       role: json['role'],
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'name': name,
//     'role': role,
//   };
// }
//
// class Movie {
//   final int id;
//   final String title;
//   final String description;
//   final String thumbnailUrl;
//   final String bannerUrl;
//   final String genre;
//   final double rating;
//   final int releaseYear;
//   final String category;
//   final String duration;
//   final String language;
//   final String director;
//   final String producer;
//   final String musicComposer;
//   final String releaseDate;
//   final List<StarCast> starCast;
//
//   Movie({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.thumbnailUrl,
//     required this.bannerUrl,
//     required this.genre,
//     required this.rating,
//     required this.releaseYear,
//     required this.category,
//     required this.duration,
//     required this.language,
//     required this.director,
//     required this.producer,
//     required this.musicComposer,
//     required this.releaseDate,
//     required this.starCast,
//   });
//
//   factory Movie.fromJson(Map<String, dynamic> json) {
//     return Movie(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       thumbnailUrl: json['thumbnailUrl'],
//       bannerUrl: json['bannerUrl'],
//       genre: json['genre'],
//       rating: (json['rating'] as num).toDouble(),
//       releaseYear: json['releaseYear'],
//       category: json['category'],
//       duration: json['duration'],
//       language: json['language'],
//       director: json['director'],
//       producer: json['producer'],
//       musicComposer: json['musicComposer'],
//       releaseDate: json['releaseDate'],
//       starCast: (json['starCast'] as List<dynamic>)
//           .map((cast) => StarCast.fromJson(cast))
//           .toList(),
//     );
//   }
//
//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'title': title,
//     'description': description,
//     'thumbnailUrl': thumbnailUrl,
//     'bannerUrl': bannerUrl,
//     'genre': genre,
//     'rating': rating,
//     'releaseYear': releaseYear,
//     'category': category,
//     'duration': duration,
//     'language': language,
//     'director': director,
//     'producer': producer,
//     'musicComposer': musicComposer,
//     'releaseDate': releaseDate,
//     'starCast': starCast.map((cast) => cast.toJson()).toList(),
//   };
// }

class StarCast {
  final String name;
  final String role;

  StarCast({
    required this.name,
    required this.role,
  });

  factory StarCast.fromJson(Map<String, dynamic> json) {
    return StarCast(
      name: json['name'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'role': role,
  };
}

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
  final String duration;
  final String language;
  final String director;
  final String producer;
  final String musicComposer;
  final String releaseDate;
  final String videoUrl; // <-- Added field
  final List<StarCast> starCast;

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
    required this.duration,
    required this.language,
    required this.director,
    required this.producer,
    required this.musicComposer,
    required this.releaseDate,
    required this.videoUrl, // <-- Added to constructor
    required this.starCast,
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
      duration: json['duration'],
      language: json['language'],
      director: json['director'],
      producer: json['producer'],
      musicComposer: json['musicComposer'],
      releaseDate: json['releaseDate'],
      videoUrl: json['videoUrl'], // <-- Extracted from JSON
      starCast: (json['starCast'] as List<dynamic>)
          .map((cast) => StarCast.fromJson(cast))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'thumbnailUrl': thumbnailUrl,
    'bannerUrl': bannerUrl,
    'genre': genre,
    'rating': rating,
    'releaseYear': releaseYear,
    'category': category,
    'duration': duration,
    'language': language,
    'director': director,
    'producer': producer,
    'musicComposer': musicComposer,
    'releaseDate': releaseDate,
    'videoUrl': videoUrl, // <-- Included in map
    'starCast': starCast.map((cast) => cast.toJson()).toList(),
  };
}
