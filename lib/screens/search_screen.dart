import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movies.dart';
import 'detail_screen.dart';

class SearchScreen extends StatefulWidget {
  final List<Movie> allMovies;

  const SearchScreen({super.key, required this.allMovies});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Movie> filtered = [];

  void _search(String query) {
    setState(() {
      filtered = widget.allMovies.where((movie) {
        final lower = query.toLowerCase();
        return movie.title.toLowerCase().contains(lower) ||
            movie.description.toLowerCase().contains(lower) ||
            movie.genre.toLowerCase().contains(lower) ||
            movie.category.toLowerCase().contains(lower) ||
            movie.rating.toString().contains(lower) ||
            movie.releaseYear.toString().contains(lower);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    filtered = widget.allMovies;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: TextField(
          controller: _controller,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: const TextStyle(color: Colors.white54),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.clear, color: Colors.white70),
              onPressed: () {
                _controller.clear();
                _search('');
              },
            ),
          ),
          onChanged: _search,
        ),
      ),
      body: filtered.isEmpty
          ? const Center(
        child: Text(
          'No results found.',
          style: TextStyle(color: Colors.white54),
        ),
      )
          : ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final movie = filtered[index];
          return ListTile(
            contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: movie.thumbnailUrl,
                width: 60,
                height: 90,
                fit: BoxFit.cover,
                placeholder: (context, url) => const SizedBox(
                  width: 60,
                  height: 90,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.yellow,
                    ),
                  ),
                ),
                errorWidget: (context, url, error) =>
                const Icon(Icons.error, color: Colors.white),
              ),
            ),
            title: Text(
              movie.title,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(movie.category,
                style: const TextStyle(color: Colors.white70)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MovieDetailScreen(movie: movie, allMovies: [],),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

