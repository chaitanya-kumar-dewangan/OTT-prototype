import 'dart:convert';
import 'dart:ui';
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

  final Color navy = const Color(0xFF001F3F);
  final Color darkRed = const Color(0xFF8B0000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  navy,
                  navy.withOpacity(0.5),
                  navy.withOpacity(0.5),
                  darkRed.withOpacity(0.6),
                  navy.withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Background Blur (only once, not per item)
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),

          // Movie Grid
          FutureBuilder<List<Movie>>(
            future: _webSeriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(color: Colors.white));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final webSeriesList = snapshot.data!;

              return GridView.builder(
                padding: const EdgeInsets.all(12),
                physics: const BouncingScrollPhysics(),
                cacheExtent: 1000,
                itemCount: webSeriesList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final series = webSeriesList[index];
                  return _GlassCard(
                    series: series,
                    allMovies: webSeriesList,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Movie series;
  final List<Movie> allMovies;

  const _GlassCard({
    required this.series,
    required this.allMovies,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailScreen(
              movie: series,
              allMovies: allMovies,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(16)),
              child: CachedNetworkImage(
                imageUrl: series.thumbnailUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                fadeInDuration: const Duration(milliseconds: 200),
                placeholder: (context, url) => Container(
                  height: 180,
                  color: Colors.grey.shade900,
                ),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error, color: Colors.red),
              ),
            ),
            // Info
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    series.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    series.genre,
                    style:
                    const TextStyle(fontSize: 12, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
