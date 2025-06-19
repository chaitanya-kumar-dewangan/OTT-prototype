import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movies.dart';
import 'genere_view_all-screen.dart';

class CategoriesScreen extends StatelessWidget {
  final List<Movie> allMovies;

  const CategoriesScreen({super.key, required this.allMovies});

  @override
  Widget build(BuildContext context) {
    final Map<String, Movie> categoryThumbMap = {};

    for (var movie in allMovies) {
      if (!categoryThumbMap.containsKey(movie.category)) {
        categoryThumbMap[movie.category] = movie;
      }
    }

    final categories = categoryThumbMap.entries.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 14,
            crossAxisSpacing: 14,
            childAspectRatio: 0.8, // Adjusted to leave space for text below image
          ),
          itemBuilder: (context, index) {
            final category = categories[index].key;
            final movie = categories[index].value;

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => GenreViewAllScreen(
                      genre: category,
                      movies: allMovies
                          .where((m) => m.category == category)
                          .toList(),
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
                        imageUrl: movie.bannerUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(color: Colors.yellow),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(Icons.error, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(color: Colors.black, blurRadius: 4),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
