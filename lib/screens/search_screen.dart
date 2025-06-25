// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import '../models/movies.dart';
// import 'detail_screen.dart';
//
// class SearchScreen extends StatefulWidget {
//   final List<Movie> allMovies;
//
//   const SearchScreen({super.key, required this.allMovies});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//   final TextEditingController _controller = TextEditingController();
//   List<Movie> filtered = [];
//
//   final Color navy = const Color(0xFF001F3F);
//   final Color darkRed = const Color(0xFF8B0000);
//   final Color accent = const Color(0xFFE50914);
//
//   void _search(String query) {
//     setState(() {
//       filtered = widget.allMovies.where((movie) {
//         final lower = query.toLowerCase();
//         return movie.title.toLowerCase().contains(lower) ||
//             movie.description.toLowerCase().contains(lower) ||
//             movie.genre.toLowerCase().contains(lower) ||
//             movie.category.toLowerCase().contains(lower) ||
//             movie.rating.toString().contains(lower) ||
//             movie.releaseYear.toString().contains(lower);
//       }).toList();
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     filtered = widget.allMovies;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: false,
//       backgroundColor: Colors.transparent,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(kToolbarHeight),
//         child: ClipRRect(
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//             child: AppBar(
//               backgroundColor: Colors.black.withOpacity(0.3),
//               elevation: 0,
//               title: TextField(
//                 controller: _controller,
//                 autofocus: true,
//                 style: const TextStyle(color: Colors.white),
//                 decoration: InputDecoration(
//                   hintText: 'Search...',
//                   hintStyle: const TextStyle(color: Colors.white54),
//                   border: InputBorder.none,
//                   suffixIcon: IconButton(
//                     icon: const Icon(Icons.clear, color: Colors.white70),
//                     onPressed: () {
//                       _controller.clear();
//                       _search('');
//                     },
//                   ),
//                 ),
//                 onChanged: _search,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 navy,
//                 navy.withOpacity(0.5),
//                 navy.withOpacity(0.5),
//                 darkRed.withOpacity(0.6),
//                 navy.withOpacity(0.6),
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//           ),
//           child: filtered.isEmpty
//               ? const Center(
//             child: Text(
//               'No results found.',
//               style: TextStyle(color: Colors.white54),
//             ),
//           )
//               : SingleChildScrollView(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
//             child: Column(
//               children: filtered.map((movie) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(16),
//                     child: BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Colors.white.withOpacity(0.1),
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(
//                             color: Colors.white.withOpacity(0.2),
//                             width: 1,
//                           ),
//                         ),
//                         child: ListTile(
//                           contentPadding: const EdgeInsets.all(8),
//                           leading: ClipRRect(
//                             borderRadius: BorderRadius.circular(8),
//                             child: CachedNetworkImage(
//                               imageUrl: movie.thumbnailUrl,
//                               width: 60,
//                               height: 90,
//                               fit: BoxFit.cover,
//                               placeholder: (context, url) => SizedBox(
//                                 width: 60,
//                                 height: 90,
//                                 child: Center(
//                                   child: CircularProgressIndicator(
//                                     strokeWidth: 2,
//                                     color: Colors.red.shade900,
//                                   ),
//                                 ),
//                               ),
//                               errorWidget: (context, url, error) =>
//                               const Icon(Icons.error, color: Colors.white),
//                             ),
//                           ),
//                           title: Text(
//                             movie.title,
//                             style: const TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                           subtitle: Text(
//                             movie.category,
//                             style: const TextStyle(color: Colors.white70),
//                           ),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (_) => MovieDetailScreen(
//                                   movie: movie,
//                                   allMovies: widget.allMovies,
//                                   // allMovies: [],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
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

  final Color navy = const Color(0xFF001F3F);
  final Color darkRed = const Color(0xFF8B0000);
  final Color accent = const Color(0xFFE50914);

  @override
  void initState() {
    super.initState();
    filtered = widget.allMovies;
  }

  void _search(String query) {
    final lower = query.toLowerCase();
    final result = widget.allMovies.where((movie) {
      return movie.title.toLowerCase().contains(lower) ||
          movie.description.toLowerCase().contains(lower) ||
          movie.genre.toLowerCase().contains(lower) ||
          movie.category.toLowerCase().contains(lower) ||
          movie.rating.toString().contains(lower) ||
          movie.releaseYear.toString().contains(lower);
    }).toList();

    if (result.length != filtered.length) {
      setState(() {
        filtered = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AppBar(
              backgroundColor: Colors.black.withOpacity(0.3),
              elevation: 0,
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
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
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
          child: filtered.isEmpty
              ? const Center(
            child: Text(
              'No results found.',
              style: TextStyle(color: Colors.white54),
            ),
          )
              : ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final movie = filtered[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: movie.thumbnailUrl,
                            width: 60,
                            height: 90,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => SizedBox(
                              width: 60,
                              height: 90,
                              child: Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.red.shade900,
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
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          movie.category,
                          style: const TextStyle(color: Colors.white70),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MovieDetailScreen(
                                movie: movie,
                                allMovies: widget.allMovies,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
