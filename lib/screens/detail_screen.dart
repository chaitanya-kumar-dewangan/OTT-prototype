import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/movies.dart';

class MovieDetailScreen extends StatefulWidget {
  final Movie movie;
  final List<Movie> allMovies;

  const MovieDetailScreen({
    super.key,
    required this.movie,
    required this.allMovies,
  });

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late YoutubePlayerController _controller;

  final Color navy = const Color(0xFF001F3F);
  final Color darkRed = const Color(0xFF8B0000);

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.movie.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        forceHD: true,
        enableCaption: true,
        useHybridComposition: true,
        controlsVisibleAtStart: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showDialog(String message) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (_) => Dialog(
        backgroundColor: Colors.white.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text('$label: $value', style: const TextStyle(color: Colors.white70)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final movie = widget.movie;
    final recs = (widget.allMovies
        .where((m) => m.category == movie.category && m.id != movie.id)
        .toList()
      ..shuffle(Random()))
        .take(6)
        .toList();

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [navy, navy.withOpacity(0.5), darkRed.withOpacity(0.6), navy.withOpacity(0.6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: isLandscape
              ? _buildLandscapeVideo()
              : Column(
            children: [
              _buildYoutubePlayer(),
              Expanded(
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(child: _buildMovieDetails(movie)),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      sliver: _buildRecommendedGrid(recs),
                    ),
                    const SliverToBoxAdapter(child: SizedBox(height: 30)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildYoutubePlayer() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressColors: const ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Colors.white,
        ),
        bottomActions: const [
          CurrentPosition(),
          ProgressBar(isExpanded: true),
          RemainingDuration(),
          PlaybackSpeedButton(),
          FullScreenButton(),
        ],
        topActions: [
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              widget.movie.title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.hd, color: Colors.white),
            onPressed: () => _showDialog("Quality depends on YouTube settings."),
          ),
        ],
      ),
    );
  }

  Widget _buildLandscapeVideo() {
    return Center(
      child: _buildYoutubePlayer(),
    );
  }

  Widget _buildMovieDetails(Movie movie) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(movie.title, style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          Text('${movie.releaseYear} • ${movie.genre} • ⭐ ${movie.rating}', style: const TextStyle(color: Colors.white70)),
          const SizedBox(height: 12),
          _infoRow("Duration", movie.duration),
          const SizedBox(height: 8),
          Text(movie.description, style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.white.withOpacity(0.2)),
                    ),
                  ),
                  icon: const Icon(Icons.play_arrow),
                  label: const Text("Play"),
                  onPressed: () => _controller.play(),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                icon: const Icon(Icons.bookmark_border, color: Colors.white),
                onPressed: () => _showDialog("Coming Soon"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _infoRow("Language", movie.language),
          _infoRow("Director", movie.director),
          _infoRow("Producer", movie.producer),
          _infoRow("Music", movie.musicComposer),
          _infoRow("Release Date", movie.releaseDate),
          const SizedBox(height: 16),
          const Text('Star Cast', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ...movie.starCast.map(
                (actor) => Text('${actor.name} as ${actor.role}', style: const TextStyle(color: Colors.white70)),
          ),
          const SizedBox(height: 16),
          const Text('You May Like', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildRecommendedGrid(List<Movie> recs) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
            (ctx, idx) {
          final m = recs[idx];
          return GestureDetector(
            onTap: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => MovieDetailScreen(movie: m, allMovies: widget.allMovies)),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: CachedNetworkImage(
                        imageUrl: m.thumbnailUrl,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                        const Center(child: CircularProgressIndicator(color: Colors.white)),
                        errorWidget: (_, __, ___) => const Icon(Icons.error, color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(m.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis),
                        const SizedBox(height: 4),
                        Text(m.genre,
                            style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        childCount: recs.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 0.65,
      ),
    );
  }
}
