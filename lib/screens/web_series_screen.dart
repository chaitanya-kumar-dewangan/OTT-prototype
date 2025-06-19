// lib/screens/web_series_screen.dart

import 'package:flutter/material.dart';
import 'package:ott/screens/webseries_detail.dart';

import '../data/web_series.dart';
import '../models/movies.dart';
import 'detail_screen.dart';


class WebSeriesScreen extends StatelessWidget {
  const WebSeriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Parse the JSON into Movie model list
    final List<Movie> webSeriesList = webSeriesJsonList
        .map((json) => Movie.fromJson(json))
        .where((movie) => movie.category == 'Web Series')
        .toList();

    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Web Series'),
      // ),
      body: GridView.builder(
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
                  builder: (_) => MovieDetailScreen(movie: series, allMovies: [],),
                  // builder: (_) => WebSeriesDetailScreen(movie: series),
                ),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      series.thumbnailUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
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
      ),
    );
  }
}
