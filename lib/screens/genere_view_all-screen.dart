// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../models/movies.dart';
// import 'detail_screen.dart';
//
// class GenreViewAllScreen extends StatelessWidget {
//   final String genre;
//   final List<Movie> movies;
//
//   const GenreViewAllScreen({
//     required this.genre,
//     required this.movies,
//     super.key,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: Text('$genre Movies'),
//         backgroundColor: Colors.transparent,
//       ),
//       body: GridView.builder(
//         padding: const EdgeInsets.all(12),
//         itemCount: movies.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           mainAxisSpacing: 12,
//           crossAxisSpacing: 12,
//           childAspectRatio: 0.7,
//         ),
//         itemBuilder: (_, index) {
//           final movie = movies[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => MovieDetailScreen(
//                     movie: movie,
//                     allMovies: movies, // ✅ Pass full movie list for recommendations
//                   ),
//                 ),
//               );
//             },
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: CachedNetworkImage(
//                       imageUrl: movie.thumbnailUrl,
//                       fit: BoxFit.cover,
//                       width: double.infinity,
//                       placeholder: (context, url) => const Center(
//                         child: CircularProgressIndicator(color: Colors.white),
//                       ),
//                       errorWidget: (context, url, error) => const Center(
//                         child: Icon(Icons.error, color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 6),
//                 Text(
//                   movie.title,
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   '${movie.releaseYear} • ${movie.genre}',
//                   maxLines: 1,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movies.dart';
import 'detail_screen.dart';

class GenreViewAllScreen extends StatelessWidget {
  final String genre;
  final List<Movie> movies;

  const GenreViewAllScreen({
    super.key,
    required this.genre,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    // Define theme colors
    const Color navy = Color(0xFF001F3F);
    const Color darkRed = Color(0xFF8B0000);

    return Scaffold(
      backgroundColor: navy.withOpacity(0.5),
      appBar: AppBar(
        backgroundColor: navy.withOpacity(0.5),
        surfaceTintColor: navy.withOpacity(0.5),
        elevation: 0,
        centerTitle: true,
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          '$genre',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

      ),
      body: Container(
        decoration:BoxDecoration(
          gradient: LinearGradient(
            colors: [

              // Color(0xFF001F3F), Color(0xFF8B0000)
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
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: GridView.builder(
              itemCount: movies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (context, index) {
                final movie = movies[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailScreen(movie: movie, allMovies: movies),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.white.withOpacity(0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: CachedNetworkImage(
                                imageUrl: movie.thumbnailUrl,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(color: Colors.white),
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.white),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                              child: Text(
                                movie.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, bottom: 8),
                              child: Text(
                                '${movie.releaseYear} • ${movie.genre}',
                                style: const TextStyle(color: Colors.white70, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
