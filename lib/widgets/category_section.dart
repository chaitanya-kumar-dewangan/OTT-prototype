// import 'package:flutter/material.dart';
// import '../models/movies.dart';
//
// class CategorySection extends StatelessWidget {
//   final String title;
//   final List<Movie> movies;
//   final Function(Movie) onMovieTap;
//
//   const CategorySection({
//     super.key,
//     required this.title,
//     required this.movies,
//     required this.onMovieTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Text(
//             title,
//             style: const TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//         ),
//         SizedBox(
//           height: 160,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: movies.length,
//             itemBuilder: (context, index) {
//               final movie = movies[index];
//               return GestureDetector(
//                 onTap: () => onMovieTap(movie),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 4),
//                   child: Column(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Image.network(
//                           movie.thumbnailUrl,
//                           width: 112,
//                           height: 137,
//                           fit: BoxFit.cover,
//                           errorBuilder: (_, __, ___) =>
//                               const Icon(Icons.error, color: Colors.white),
//                         ),
//                       ),
//                       const SizedBox(height: 5),
//                       SizedBox(
//                         width: 112,
//                         child: Text(
//                           movie.title,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 12,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/movies.dart';
import '../screens/genere_view_all-screen.dart';

class CategorySection extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final Function(Movie) onMovieTap;

  const CategorySection({
    super.key,
    required this.title,
    required this.movies,
    required this.onMovieTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title Row with View All Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GenreViewAllScreen(
                        genre: title,
                        movies: movies,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.grid_view, color: Colors.blueAccent.shade700, size: 18),
                label:  Text(
                  'View All',
                  style: TextStyle(color: Colors.blueAccent.shade700, fontSize: 14),
                ),
              ),
            ],
          ),
        ),

        // Horizontal movie list
        SizedBox(
          height: 160,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return GestureDetector(
                onTap: () => onMovieTap(movie),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          movie.thumbnailUrl,
                          width: 112,
                          height: 137,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                          const Icon(Icons.error, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 112,
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
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
      ],
    );
  }
}
