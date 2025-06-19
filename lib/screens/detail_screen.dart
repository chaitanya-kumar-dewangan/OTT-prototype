// import 'package:flutter/material.dart';
// import '../models/movies.dart';
//
// class MovieDetailScreen extends StatelessWidget {
//   final Movie movie;
//
//   const MovieDetailScreen({super.key, required this.movie});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         title: Text(movie.title, style: const TextStyle(color: Colors.white)),
//       ),
//       body: ListView(
//         children: [
//           // Banner Image with Play Button and Title
//           Stack(
//             alignment: Alignment.center,
//             children: [
//               // Banner Image
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Image.network(
//                   movie.bannerUrl,
//                   height: 250,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   loadingBuilder: (context, child, loadingProgress) {
//                     if (loadingProgress == null) return child;
//                     return const SizedBox(
//                       height: 250,
//                       child: Center(child: CircularProgressIndicator()),
//                     );
//                   },
//                   errorBuilder: (_, __, ___) => const SizedBox(
//                     height: 250,
//                     child: Icon(Icons.error, color: Colors.white),
//                   ),
//                 ),
//               ),
//
//               // Gradient overlay
//               Container(
//                 width: double.infinity,
//                 height: 250,
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [
//                       Colors.transparent,
//                       Colors.transparent,
//                       Colors.transparent,
//                       Colors.transparent,
//                       Colors.black,
//                     ],
//                     begin: Alignment.topCenter,
//                     end: Alignment.bottomCenter,
//                   ),
//                 ),
//               ),
//
//               // Center Play Button
//               IconButton(
//                 iconSize: 64,
//                 icon: const Icon(Icons.play_circle_fill, color: Colors.white),
//                 onPressed: () {
//                   showDialog(
//                     context: context,
//                     barrierColor: Colors.black54,
//                     builder: (BuildContext context) {
//                       return Dialog(
//                         backgroundColor: Colors.black.withOpacity(0.8),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                           side: const BorderSide(
//                             color: Colors.white,
//                             width: 0.5,
//                           ),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.all(24.0),
//                           child: Text(
//                             "Available Soon only on CinestreamX",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       );
//
//                     },
//                   );
//                 },
//               ),
//
//               // Bottom-left Title
//               Positioned(
//                 left: 16,
//                 bottom: 16,
//                 child: Text(
//                   movie.title,
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//
//           // Metadata & Description
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
//
//                 // Action Buttons
//                 Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red,
//                           foregroundColor: Colors.white,
//                           padding: const EdgeInsets.symmetric(vertical: 12),
//                         ),
//                         icon: const Icon(Icons.play_arrow),
//                         label: const Text("Play"),
//                         onPressed: ()
//                         {
//                           // Optionally use the same dialog here
//                           showDialog(
//                             context: context,
//                             barrierColor: Colors.black54,
//                             builder: (BuildContext context) {
//                               return Dialog(
//                                 backgroundColor: Colors.black.withOpacity(0.8),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(12),
//                                 ),
//                                 child: const Padding(
//                                   padding: EdgeInsets.all(24.0),
//                                   child: Text(
//                                     "Not available yet",
//                                     textAlign: TextAlign.center,
//                                     style: TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.w500,
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     IconButton(
//                       icon: const Icon(Icons.bookmark_border, color: Colors.white),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 30),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//

import 'package:flutter/material.dart';
import '../models/movies.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black26.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              color: Colors.white,
              width: 0.3,
            ),
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
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text("${movie.title}", style: const TextStyle(color: Colors.white)),
      // ),
      body: ListView(
        children: [
          // Banner Image with Play Button and Title
          Stack(
            alignment: Alignment.center,
            children: [
              // Banner Image
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Image.network(
                  movie.bannerUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                      height: 250,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (_, __, ___) => const SizedBox(
                    height: 250,
                    child: Icon(Icons.error, color: Colors.white),
                  ),
                ),
              ),

              // Gradient overlay
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
                      Colors.black,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),

              // Center Play Button
              IconButton(
                iconSize: 64,
                icon: const Icon(Icons.play_circle_fill, color: Colors.black45),
                onPressed: () {
                  _showDialog(context, "Available Soon only on CinestreamX");
                },
              ),

              // Bottom-left Title
              Positioned(
                left: 16,
                bottom: 16,
                child: Text(
                  movie.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // Metadata & Description
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

                // Action Buttons
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
                        onPressed: () {
                          _showDialog(context, "Available Soon only on CinestreamX");
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.bookmark_border, color: Colors.white),
                      onPressed: () {
                        _showDialog(context, "Coming Soon");
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
