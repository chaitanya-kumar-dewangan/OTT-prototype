// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../models/movies.dart';
// import '../widgets/banner_carausel.dart';
// import '../widgets/category_section.dart';
// import 'detail_screen.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   List<Movie> allMovies = [];
//   int _selectedIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadMovies();
//   }
//
//   Future<void> _loadMovies() async {
//     final String response = await rootBundle.loadString(
//       'lib/data/genre_movies.json',
//     );
//     final List<dynamic> data = json.decode(response);
//     setState(() {
//       allMovies = data.map((json) => Movie.fromJson(json)).toList();
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final categories = allMovies.map((m) => m.category).toSet().toList();
//
//     final List<Widget> pages = [
//       _buildHomeContent(categories),
//       const Center(
//         child: Text('Movies', style: TextStyle(color: Colors.white)),
//       ),
//       const Center(
//         child: Text('Web Series', style: TextStyle(color: Colors.white)),
//       ),
//       const Center(
//         child: Text('Saved', style: TextStyle(color: Colors.white)),
//       ),
//     ];
//
//     return Scaffold(
//       extendBody: true,
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         title: const Text("CinestreamX", style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: pages[_selectedIndex],
//
//       // Custom transparent bottom nav
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(left: 16, right: 16, bottom: 3.0),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(30),
//           child: Container(
//             height: 60,
//             decoration: BoxDecoration(
//               color: Colors.transparent,
//               // border: Border.all(color: Colors.white30,)// Fully transparent
//               // color: Colors.transparent, // Fully transparent
//             ),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.8), // Optional subtle blur
//                 borderRadius: BorderRadius.circular(30),
//                 border: Border.all(color: Colors.white38),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   _buildNavIcon(Icons.home_rounded, 0),
//                   _buildNavIcon(Icons.movie_rounded, 1),
//                   _buildNavIcon(Icons.tv_rounded, 2),
//                   _buildNavIcon(Icons.bookmark_rounded, 3),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNavIcon(IconData icon, int index) {
//     final isSelected = _selectedIndex == index;
//     return GestureDetector(
//       onTap: () => setState(() => _selectedIndex = index),
//       child: Icon(
//         icon,
//         size: 28,
//         color: isSelected ? Colors.white : Colors.grey,
//       ),
//     );
//   }
//
//   Widget _buildHomeContent(List<String> categories) {
//     return allMovies.isEmpty
//         ? const Center(child: CircularProgressIndicator())
//         : ListView(
//             padding: const EdgeInsets.only(bottom: 60),
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: BannerCarousel(banners: allMovies.take(5).toList()),
//               ),
//               const SizedBox(height: 8),
//               for (final category in categories)
//                 CategorySection(
//                   title: category,
//                   movies: allMovies
//                       .where((m) => m.category == category)
//                       .toList(),
//                   onMovieTap: (movie) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (_) => MovieDetailScreen(movie: movie),
//                       ),
//                     );
//                   },
//                 ),
//             ],
//           );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/movies.dart';
import '../widgets/banner_carausel.dart';
import '../widgets/category_section.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> allMovies = [];
  int _selectedIndex = 0;
  TextEditingController _searchController = TextEditingController();
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final String response = await rootBundle.loadString(
      'lib/data/genre_movies.json',
    );
    final List<dynamic> data = json.decode(response);
    setState(() {
      allMovies = data.map((json) => Movie.fromJson(json)).toList();
    });
  }

  List<Movie> _filteredMovies() {
    if (searchQuery.isEmpty) return allMovies;

    return allMovies.where((movie) {
      final query = searchQuery.toLowerCase();
      return movie.title.toLowerCase().contains(query) ||
          movie.description.toLowerCase().contains(query) ||
          movie.genre.toLowerCase().contains(query) ||
          movie.category.toLowerCase().contains(query) ||
          movie.releaseYear.toString().contains(query) ||
          movie.rating.toString().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _filteredMovies();
    final categories = filtered.map((m) => m.category).toSet().toList();

    final List<Widget> pages = [
      _buildHomeContent(categories, filtered),
      const Center(
        child: Text('Movies', style: TextStyle(color: Colors.white)),
      ),
      const Center(
        child: Text('Web Series', style: TextStyle(color: Colors.white)),
      ),
      const Center(
        child: Text('Saved', style: TextStyle(color: Colors.white)),
      ),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search movies...',
            hintStyle: TextStyle(color: Colors.white70),
            filled: true,
            fillColor: Colors.white10,
            contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none,
            ),
            prefixIcon: const Icon(Icons.search, color: Colors.white70),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
              icon: const Icon(Icons.clear, color: Colors.white),
              onPressed: () {
                _searchController.clear();
                setState(() {
                  searchQuery = '';
                });
              },
            )
                : null,
          ),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
        ),
      ),
      body: pages[_selectedIndex],

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 3.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Colors.transparent,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white38),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavIcon(Icons.home_rounded, 0),
                  _buildNavIcon(Icons.movie_rounded, 1),
                  _buildNavIcon(Icons.tv_rounded, 2),
                  _buildNavIcon(Icons.bookmark_rounded, 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Icon(
        icon,
        size: 28,
        color: isSelected ? Colors.white : Colors.grey,
      ),
    );
  }

  Widget _buildHomeContent(List<String> categories, List<Movie> filteredMovies) {
    return allMovies.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : ListView(
      padding: const EdgeInsets.only(bottom: 60),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BannerCarousel(banners: filteredMovies.take(5).toList()),
        ),
        const SizedBox(height: 8),
        for (final category in categories)
          CategorySection(
            title: category,
            movies: filteredMovies
                .where((m) => m.category == category)
                .toList(),
            onMovieTap: (movie) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MovieDetailScreen(movie: movie),
                ),
              );
            },
          ),
      ],
    );
  }
}
