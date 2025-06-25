import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movies.dart';
import 'detail_screen.dart';

class WebSeriesScreen2 extends StatefulWidget {
  const WebSeriesScreen2({super.key});

  @override
  State<WebSeriesScreen2> createState() => _WebSeriesScreenState();
}

class _WebSeriesScreenState extends State<WebSeriesScreen2> {
  late Future<List<Movie>> _webSeriesFuture;

  @override
  void initState() {
    super.initState();
    _webSeriesFuture = _loadWebSeriesFromJson();
  }

  Future<List<Movie>> _loadWebSeriesFromJson() async {
    final String jsonString = await rootBundle.loadString(
      'lib/data/genre_movies.json',
    );
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList
        .map((json) => Movie.fromJson(json))
        .where((movie) => movie.category == 'Web Series')
        .toList();
  }

  final Color navy = const Color(0xFF001F3F);
  final Color darkRed = const Color(0xFF8B0000);
  final Color accent = const Color(0xFFE50914);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: navy,
        backgroundColor: navy,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Web Series',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: ClipRRect(
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF001F3F), Color(0xFF001F3F)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
              ),
            ),
          ),
        ),
      ),

      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Glassy Gradient Background
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
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(color: Colors.black.withOpacity(0.2)),
          ),

          // Future content
          FutureBuilder<List<Movie>>(
            future: _webSeriesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              final webSeriesList = snapshot.data!;

              return GridView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: webSeriesList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.65,
                ),
                itemBuilder: (context, index) {
                  final series = webSeriesList[index];
                  return _GlassCard(series: series, allMovies: webSeriesList);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _GlassCard extends StatefulWidget {
  final Movie series;
  final List<Movie> allMovies;

  const _GlassCard({required this.series, required this.allMovies});

  @override
  State<_GlassCard> createState() => _GlassCardState();
}

class _GlassCardState extends State<_GlassCard> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => isTapped = true),
      onTapUp: (_) => setState(() => isTapped = false),
      onTapCancel: () => setState(() => isTapped = false),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailScreen(
              movie: widget.series,
              allMovies: widget.allMovies,
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: isTapped ? 30 : 20,
              sigmaY: isTapped ? 30 : 20,
            ),
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
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: widget.series.thumbnailUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: Colors.red.shade900,
                        ),
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
                          widget.series.title,
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
                          widget.series.genre,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
