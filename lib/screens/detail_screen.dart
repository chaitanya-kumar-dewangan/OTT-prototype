// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../models/movies.dart';
//
// class MovieDetailScreen extends StatelessWidget {
//   final Movie movie;
//   final List<Movie> allMovies;
//
//   const MovieDetailScreen({
//     super.key,
//     required this.movie,
//     required this.allMovies,
//   });
//
//   void _showDialog(BuildContext context, String message) {
//     showDialog(
//       context: context,
//       barrierColor: Colors.black54,
//       builder: (BuildContext context) {
//         return Dialog(
//           backgroundColor: Colors.black26.withOpacity(0.5),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(30),
//             side: const BorderSide(color: Colors.white, width: 0.3),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Text(
//               message,
//               textAlign: TextAlign.center,
//               style: const TextStyle(
//                 color: Colors.white,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w500,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Movie> recommended = List.from(allMovies)
//       ..removeWhere((m) => m.title == movie.title)
//       ..shuffle(Random());
//
//     final List<Movie> topRecommendations = recommended.take(6).toList();
//
//     return Scaffold(
//       backgroundColor: Colors.black,
//       extendBodyBehindAppBar: true,
//       body: ListView(
//         children: [
//           // Banner Section
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: CachedNetworkImage(
//                   imageUrl: movie.bannerUrl,
//                   height: 250,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   placeholder: (context, url) => const SizedBox(
//                     height: 250,
//                     child: Center(
//                       child: CircularProgressIndicator(color: Colors.yellow),
//                     ),
//                   ),
//                   errorWidget: (context, url, error) => const SizedBox(
//                     height: 250,
//                     child: Icon(Icons.error, color: Colors.white),
//                   ),
//                 ),
//               ),
//               Container(
//                 width: double.infinity,
//                 height: 250,
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.transparent, Colors.black],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//               ),
//               IconButton(
//                 iconSize: 64,
//                 icon: const Icon(Icons.play_circle_fill, color: Colors.black45),
//                 onPressed: () {
//                   _showDialog(context, "Available Soon only on CinestreamX");
//                 },
//               ),
//               Positioned(
//                 left: 16,
//                 bottom: 20,
//                 right: 16,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       movie.title,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       '${movie.genre} | ${movie.releaseYear}',
//                       style: const TextStyle(color: Colors.white70, fontSize: 12),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//
//           // Detail Section
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "${movie.releaseYear} • ${movie.genre} • ⭐ ${movie.rating}",
//                   style: const TextStyle(color: Colors.grey, fontSize: 14),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   movie.description,
//                   style: const TextStyle(color: Colors.white, fontSize: 16),
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red.shade900,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                         ),
//                         icon: const Icon(Icons.play_arrow),
//                         label: const Text("Play"),
//                         onPressed: () {
//                           _showDialog(context, "Available Soon only on CinestreamX");
//                         },
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     IconButton(
//                       icon: const Icon(Icons.bookmark_border, color: Colors.white),
//                       onPressed: () => _showDialog(context, "Coming Soon"),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 30),
//                 const Text(
//                   'More Like This',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//               ],
//             ),
//           ),
//
//           // Grid Section
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             child: GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               itemCount: topRecommendations.length,
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 14,
//                 crossAxisSpacing: 14,
//                 childAspectRatio: 0.65,
//               ),
//               itemBuilder: (context, index) {
//                 final recMovie = topRecommendations[index];
//                 return GestureDetector(
//                   onTap: () {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => MovieDetailScreen(
//                           movie: recMovie,
//                           allMovies: allMovies,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white10,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         ClipRRect(
//                           borderRadius:
//                           const BorderRadius.vertical(top: Radius.circular(12)),
//                           child: CachedNetworkImage(
//                             imageUrl: recMovie.thumbnailUrl,
//                             height: 160,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                             placeholder: (context, url) => const Center(
//                               child: CircularProgressIndicator(color: Colors.yellow),
//                             ),
//                             errorWidget: (context, url, error) =>
//                             const Icon(Icons.error, color: Colors.white),
//                           ),
//                         ),
//                         Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             recMovie.title,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 30),
//         ],
//       ),
//     );
//   }
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movies.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;
  final List<Movie> allMovies;

  const MovieDetailScreen({
    super.key,
    required this.movie,
    required this.allMovies,
  });

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black26.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(color: Colors.white, width: 0.3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Movie> recommended = List.from(allMovies)
      ..removeWhere((m) => m.title == movie.title)
      ..shuffle(Random());

    final List<Movie> topRecommendations = recommended.take(6).toList();

    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: ListView(
        children: [
          // Banner Section
          Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: CachedNetworkImage(
                  imageUrl: movie.bannerUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const SizedBox(
                    height: 250,
                    child: Center(child: CircularProgressIndicator(color: Colors.yellow)),
                  ),
                  errorWidget: (context, url, error) => const SizedBox(
                    height: 250,
                    child: Icon(Icons.error, color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 250,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.transparent,
                      Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              IconButton(
                iconSize: 64,
                icon: const Icon(Icons.play_circle_fill, color: Colors.black45),
                onPressed: () => _showDialog(context, "Available Soon only on CinestreamX"),
              ),
              Positioned(
                left: 16,
                bottom: 12,
                right: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Text(
                    //   '${movie.genre} | ${movie.releaseYear}',
                    //   style: const TextStyle(color: Colors.white70, fontSize: 12),
                    // ),
                  ],
                ),
              ),
            ],
          ),

          // Detail Section
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${movie.releaseYear} • ${movie.genre} • ⭐ ${movie.rating}",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 12),
                Text(
                  movie.description,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 20),

                _buildInfoRow("Duration", movie.duration),
                _buildInfoRow("Language", movie.language),
                _buildInfoRow("Director", movie.director),
                _buildInfoRow("Producer", movie.producer),
                _buildInfoRow("Music", movie.musicComposer),
                _buildInfoRow("Release Date", movie.releaseDate),

                const SizedBox(height: 20),
                const Text(
                  'Star Cast',
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                ...movie.starCast.map((actor) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    '${actor.name} as ${actor.role}',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                )),

                const SizedBox(height: 30),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade900,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        icon: const Icon(Icons.play_arrow),
                        label: const Text("Play"),
                        onPressed: () => _showDialog(context, "Available Soon only on CinestreamX"),
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border, color: Colors.white),
                      onPressed: () => _showDialog(context, "Coming Soon"),
                    ),
                  ],
                ),

                const SizedBox(height: 30),
                const Text(
                  'You May Like',
                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),

          // More Like This Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: topRecommendations.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.65,
              ),
              itemBuilder: (context, index) {
                final recMovie = topRecommendations[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailScreen(
                          movie: recMovie,
                          allMovies: allMovies,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                          child: CachedNetworkImage(
                            imageUrl: recMovie.thumbnailUrl,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(color: Colors.yellow),
                            ),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error, color: Colors.white),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            recMovie.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        "$label: $value",
        style: const TextStyle(color: Colors.white70, fontSize: 14),
      ),
    );
  }
}
