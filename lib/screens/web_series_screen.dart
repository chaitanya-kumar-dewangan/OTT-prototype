// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../models/movies.dart';
// import 'detail_screen.dart';
//
// class WebSeriesScreen extends StatefulWidget {
//   const WebSeriesScreen({super.key});
//
//   @override
//   State<WebSeriesScreen> createState() => _WebSeriesScreenState();
// }
//
// class _WebSeriesScreenState extends State<WebSeriesScreen> {
//   late Future<List<Movie>> _webSeriesFuture;
//
//   @override
//   void initState() {
//     super.initState();
//     _webSeriesFuture = _loadWebSeriesFromJson();
//   }
//
//   Future<List<Movie>> _loadWebSeriesFromJson() async {
//     final String jsonString =
//     await rootBundle.loadString('lib/data/genre_movies.json');
//     final List<dynamic> jsonList = json.decode(jsonString);
//
//     return jsonList
//         .map((json) => Movie.fromJson(json))
//         .where((movie) => movie.category == 'Web Series')
//         .toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<List<Movie>>(
//         future: _webSeriesFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator(color: Colors.red));
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//
//           final webSeriesList = snapshot.data!;
//
//           return GridView.builder(
//             padding: const EdgeInsets.all(10),
//             itemCount: webSeriesList.length,
//             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2, // Show 2 cards in a row
//               crossAxisSpacing: 10,
//               mainAxisSpacing: 10,
//               childAspectRatio: 0.7,
//             ),
//             itemBuilder: (context, index) {
//               final series = webSeriesList[index];
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => MovieDetailScreen(
//                         movie: series,
//                         allMovies: [], // or pass webSeriesList if needed
//                       ),
//                     ),
//                   );
//                 },
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Expanded(
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: CachedNetworkImage(
//                           imageUrl: series.thumbnailUrl,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                           placeholder: (context, url) => const Center(
//                             child: CircularProgressIndicator(color: Colors.red),
//                           ),
//                           errorWidget: (context, url, error) =>
//                           const Icon(Icons.error, color: Colors.red),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       series.title,
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                       ),
//                     ),
//                     Text(
//                       series.genre,
//                       style: const TextStyle(fontSize: 12, color: Colors.grey),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movies.dart';
import 'detail_screen.dart';

class WebSeriesScreen extends StatefulWidget {
  const WebSeriesScreen({super.key});

  @override
  State<WebSeriesScreen> createState() => _WebSeriesScreenState();
}

class _WebSeriesScreenState extends State<WebSeriesScreen> {
  late Future<List<Movie>> _webSeriesFuture;

  @override
  void initState() {
    super.initState();
    _webSeriesFuture = _loadWebSeriesFromJson();
  }

  Future<List<Movie>> _loadWebSeriesFromJson() async {
    final String jsonString =
    await rootBundle.loadString('lib/data/genre_movies.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList
        .map((json) => Movie.fromJson(json))
        .where((movie) => movie.category == 'Web Series')
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Movie>>(
        future: _webSeriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.yellow));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final webSeriesList = snapshot.data!;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: webSeriesList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Show 2 cards in a row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (context, index) {
              final series = webSeriesList[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MovieDetailScreen(
                        movie: series,
                        allMovies: webSeriesList, // ✅ FIXED: Pass list for recommendations
                      ),
                    ),
                  );
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: CachedNetworkImage(
                          imageUrl: series.thumbnailUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(color: Colors.yellow),
                          ),
                          errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      series.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      series.genre,
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
