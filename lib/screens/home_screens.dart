// // // // import 'dart:convert';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:flutter/services.dart';
// // // // import 'package:ott/screens/downloads.dart';
// // // // import 'package:ott/screens/web_series_screen.dart';
// // // // import '../models/movies.dart';
// // // // import '../widgets/banner_carausel.dart';
// // // // import '../widgets/category_section.dart';
// // // // import 'detail_screen.dart';
// // // // import 'drawer.dart';
// // // // import 'search_screen.dart';
// // // //
// // // // class HomeScreen extends StatefulWidget {
// // // //   const HomeScreen({super.key});
// // // //
// // // //   @override
// // // //   State<HomeScreen> createState() => _HomeScreenState();
// // // // }
// // // //
// // // // class _HomeScreenState extends State<HomeScreen> {
// // // //   List<Movie> allMovies = [];
// // // //   int _selectedIndex = 0;
// // // //
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _loadMovies();
// // // //   }
// // // //
// // // //   Future<void> _loadMovies() async {
// // // //     final String response = await rootBundle.loadString(
// // // //       'lib/data/genre_movies.json',
// // // //     );
// // // //     final List<dynamic> data = json.decode(response);
// // // //     setState(() {
// // // //       allMovies = data.map((json) => Movie.fromJson(json)).toList();
// // // //     });
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     final categories = allMovies.map((m) => m.category).toSet().toList();
// // // //
// // // //     final List<Widget> pages = [
// // // //       _buildHomeContent(categories),
// // // //       DownloadsScreen2(allMovies: allMovies),
// // // //       // const Center(
// // // //       //   child: Text('Web Series', style: TextStyle(color: Colors.white)),
// // // //       // ),
// // // //       WebSeriesScreen(),
// // // //       DownloadsScreen2(allMovies: allMovies),
// // // //     ];
// // // //
// // // //     return Scaffold(
// // // //       extendBody: true,
// // // //       backgroundColor: Colors.black,
// // // //       drawer: CustomDrawer(allMovies: allMovies),
// // // //       appBar: AppBar(
// // // //         backgroundColor: Colors.transparent,
// // // //         elevation: 0,
// // // //         leading: Builder(
// // // //           builder: (context) => IconButton(
// // // //             icon: const Icon(Icons.menu, color: Colors.white),
// // // //             onPressed: () => Scaffold.of(context).openDrawer(),
// // // //           ),
// // // //         ),
// // // //         title: GestureDetector(
// // // //           onTap: () {
// // // //             Navigator.push(
// // // //               context,
// // // //               MaterialPageRoute(
// // // //                 builder: (_) => SearchScreen(allMovies: allMovies),
// // // //               ),
// // // //             );
// // // //           },
// // // //           child: AbsorbPointer(
// // // //             child: TextField(
// // // //               readOnly: true,
// // // //               style: const TextStyle(color: Colors.white),
// // // //               decoration: InputDecoration(
// // // //                 hintText: 'Search movies...',
// // // //                 hintStyle: const TextStyle(color: Colors.white70),
// // // //                 filled: true,
// // // //                 fillColor: Colors.white10,
// // // //                 contentPadding: const EdgeInsets.symmetric(
// // // //                   vertical: 8,
// // // //                   horizontal: 16,
// // // //                 ),
// // // //                 border: OutlineInputBorder(
// // // //                   borderRadius: BorderRadius.circular(30),
// // // //                   borderSide: BorderSide.none,
// // // //                 ),
// // // //                 suffixIcon: const Icon(Icons.search, color: Colors.white70),
// // // //               ),
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       ),
// // // //       body: allMovies.isEmpty
// // // //           ? const Center(child: CircularProgressIndicator(color: Colors.yellow))
// // // //           : pages[_selectedIndex],
// // // //       bottomNavigationBar: Padding(
// // // //         padding: const EdgeInsets.only(left: 16, right: 16, bottom: 3.0),
// // // //         child: ClipRRect(
// // // //           borderRadius: BorderRadius.circular(30),
// // // //           child: Container(
// // // //             height: 60,
// // // //             decoration: BoxDecoration(
// // // //               color: Colors.black.withOpacity(0.8),
// // // //               borderRadius: BorderRadius.circular(30),
// // // //               border: Border.all(color: Colors.white38),
// // // //             ),
// // // //             child: Row(
// // // //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// // // //               children: [
// // // //                 _buildNavIcon(Icons.home_rounded, 0),
// // // //                 _buildNavIcon(Icons.movie_rounded, 1),
// // // //                 _buildNavIcon(Icons.tv_rounded, 2),
// // // //                 _buildNavIcon(Icons.bookmark_rounded, 3),
// // // //               ],
// // // //             ),
// // // //           ),
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _buildNavIcon(IconData icon, int index) {
// // // //     final isSelected = _selectedIndex == index;
// // // //     return GestureDetector(
// // // //       onTap: () => setState(() => _selectedIndex = index),
// // // //       child: Icon(
// // // //         icon,
// // // //         size: 28,
// // // //         color: isSelected ? Colors.yellow : Colors.white70,
// // // //       ),
// // // //     );
// // // //   }
// // // //
// // // //   Widget _buildHomeContent(List<String> categories) {
// // // //     return ListView(
// // // //       padding: const EdgeInsets.only(bottom: 60),
// // // //       children: [
// // // //         Padding(
// // // //           padding: const EdgeInsets.symmetric(horizontal: 8.0),
// // // //           child: BannerCarousel(banners: allMovies.take(5).toList()),
// // // //         ),
// // // //         const SizedBox(height: 8),
// // // //         for (final category in categories)
// // // //           CategorySection(
// // // //             title: category,
// // // //             movies: allMovies.where((m) => m.category == category).toList(),
// // // //             onMovieTap: (movie) {
// // // //               Navigator.push(
// // // //                 context,
// // // //                 MaterialPageRoute(
// // // //                   builder: (_) =>
// // // //                       MovieDetailScreen(movie: movie, allMovies: allMovies),
// // // //                 ),
// // // //               );
// // // //             },
// // // //           ),
// // // //       ],
// // // //     );
// // // //   }
// // // // }
// // //
// // // import 'dart:ui';
// // // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:flutter/services.dart';
// // // import 'package:ott/screens/downloads.dart';
// // // import 'package:ott/screens/web_series_screen.dart';
// // // import '../models/movies.dart';
// // // import '../widgets/banner_carausel.dart';
// // // import '../widgets/category_section.dart';
// // // import 'detail_screen.dart';
// // // import 'drawer.dart';
// // // import 'search_screen.dart';
// // //
// // // class HomeScreen extends StatefulWidget {
// // //   const HomeScreen({super.key});
// // //
// // //   @override
// // //   State<HomeScreen> createState() => _HomeScreenState();
// // // }
// // //
// // // class _HomeScreenState extends State<HomeScreen> {
// // //   List<Movie> allMovies = [];
// // //   int _selectedIndex = 0;
// // //
// // //   @override
// // //   void initState() {
// // //     super.initState();
// // //     _loadMovies();
// // //   }
// // //
// // //   Future<void> _loadMovies() async {
// // //     final String response = await rootBundle.loadString(
// // //       'lib/data/genre_movies.json',
// // //     );
// // //     final List<dynamic> data = json.decode(response);
// // //     setState(() =>
// // //     allMovies = data.map((json) => Movie.fromJson(json)).toList()
// // //     );
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     final categories = allMovies.map((m) => m.category).toSet().toList();
// // //
// // //     final pages = [
// // //       _buildHomeContent(categories),
// // //       DownloadsScreen2(allMovies: allMovies),
// // //       WebSeriesScreen(),
// // //       DownloadsScreen2(allMovies: allMovies),
// // //     ];
// // //
// // //     return Scaffold(
// // //       extendBody: true,
// // //       drawer: CustomDrawer(allMovies: allMovies),
// // //       backgroundColor: Colors.transparent,
// // //       appBar: AppBar(
// // //         backgroundColor: Colors.transparent,
// // //         elevation: 0,
// // //         leading: Builder(
// // //           builder: (ctx) => IconButton(
// // //             icon: const Icon(Icons.menu, color: Colors.white),
// // //             onPressed: () => Scaffold.of(ctx).openDrawer(),
// // //           ),
// // //         ),
// // //         title: GestureDetector(
// // //           onTap: () => Navigator.push(
// // //             context,
// // //             MaterialPageRoute(builder: (_) => SearchScreen(allMovies: allMovies)),
// // //           ),
// // //           child: AbsorbPointer(
// // //             child: TextField(
// // //               readOnly: true,
// // //               style: const TextStyle(color: Colors.white),
// // //               decoration: InputDecoration(
// // //                 hintText: 'Search movies...',
// // //                 hintStyle: const TextStyle(color: Colors.white70),
// // //                 filled: true,
// // //                 fillColor: Colors.white10,
// // //                 contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
// // //                 border: OutlineInputBorder(
// // //                   borderRadius: BorderRadius.circular(30),
// // //                   borderSide: BorderSide.none,
// // //                 ),
// // //                 suffixIcon: const Icon(Icons.search, color: Colors.white70),
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //       body: Stack(
// // //         fit: StackFit.expand,
// // //         children: [
// // //           // Gradient Background
// // //           Container(
// // //             decoration: const BoxDecoration(
// // //               gradient: LinearGradient(
// // //                 colors: [
// // //                   Color(0xFF2A0A0F),
// // //
// // //                   Color(0xFF3F0B12),
// // //
// // //                   Color(0xFF2A0A0F),
// // //                   Color(0xFF2A0A0F),
// // //                   Color(0xFF2A0A0F),
// // //                   Color(0xFF2A0A0F),
// // //                   Color(0xFF2A0A0F),
// // //                   Color(0xFF3F0B12),
// // //                   Color(0xFF000000),
// // //                 ],
// // //                 begin: Alignment.topLeft,
// // //                 end: Alignment.bottomRight,
// // //               ),
// // //             ),
// // //           ),
// // //
// // //           // Frosted Glass panel
// // //           BackdropFilter(
// // //             filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
// // //             child: Container(
// // //               color: Colors.black.withOpacity(0.3),
// // //             ),
// // //           ),
// // //
// // //           // Content
// // //           allMovies.isEmpty
// // //               ? const Center(child: CircularProgressIndicator(color: Colors.yellow))
// // //               : pages[_selectedIndex],
// // //         ],
// // //       ),
// // //       bottomNavigationBar: Padding(
// // //         padding: const EdgeInsets.only(left: 16, right: 16, bottom: 3),
// // //         child: ClipRRect(
// // //           borderRadius: BorderRadius.circular(30),
// // //           child: Container(
// // //             height: 60,
// // //             decoration: BoxDecoration(
// // //               color: Colors.black.withOpacity(0.6),
// // //               borderRadius: BorderRadius.circular(30),
// // //               border: Border.all(color: Colors.red.shade700),
// // //             ),
// // //             child: Row(
// // //               mainAxisAlignment: MainAxisAlignment.spaceAround,
// // //               children: [
// // //                 _buildNavIcon(Icons.home_rounded, 0),
// // //                 _buildNavIcon(Icons.movie_rounded, 1),
// // //                 _buildNavIcon(Icons.tv_rounded, 2),
// // //                 _buildNavIcon(Icons.bookmark_rounded, 3),
// // //               ],
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildNavIcon(IconData icon, int index) {
// // //     final isSelected = _selectedIndex == index;
// // //     return GestureDetector(
// // //       onTap: () => setState(() => _selectedIndex = index),
// // //       child: Icon(
// // //         icon,
// // //         size: 28,
// // //         color: isSelected ? Colors.redAccent : Colors.white70,
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildHomeContent(List<String> categories) {
// // //     return ListView(
// // //       padding: const EdgeInsets.only(bottom: 60),
// // //       children: [
// // //         Padding(
// // //           padding: const EdgeInsets.symmetric(horizontal: 8),
// // //           child: BannerCarousel(banners: allMovies.take(5).toList()),
// // //         ),
// // //         const SizedBox(height: 8),
// // //         for (final category in categories)
// // //           CategorySection(
// // //             title: category,
// // //             movies: allMovies.where((m) => m.category == category).toList(),
// // //             onMovieTap: (movie) => Navigator.push(
// // //               context,
// // //               MaterialPageRoute(
// // //                 builder: (_) => MovieDetailScreen(
// // //                   movie: movie,
// // //                   allMovies: allMovies,
// // //                 ),
// // //               ),
// // //             ),
// // //           ),
// // //       ],
// // //     );
// // //   }
// // // }

import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movies.dart';
import '../widgets/banner_carausel.dart';
import '../widgets/category_section.dart';
import 'detail_screen.dart';
import 'drawer.dart';
import 'search_screen.dart';
import 'downloads.dart';
import 'web_series_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> allMovies = [];
  int _selectedIndex = 0;

  final Color navy = const Color(0xFF001F3F);
  final Color darkRed = const Color(0xFF8B0000);
  final Color accent = const Color(0xFFE50914);

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  Future<void> _loadMovies() async {
    final jsonStr = await rootBundle.loadString('lib/data/genre_movies.json');
    final data = json.decode(jsonStr) as List<dynamic>;
    setState(() => allMovies = data.map((j) => Movie.fromJson(j)).toList());
  }

  @override
  Widget build(BuildContext context) {
    final categories = allMovies.map((m) => m.category).toSet().toList();
    final pages = [
      _buildHomeContent(categories),
      DownloadsScreen2(allMovies: allMovies),
      WebSeriesScreen(),
      DownloadsScreen2(allMovies: allMovies),
    ];

    return Scaffold(
      extendBody: true,
      drawer: CustomDrawer(allMovies: allMovies),
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'CinestreamX',
          style: TextStyle(
            color: Colors.white.withOpacity(0.9),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white70),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SearchScreen(allMovies: allMovies)),
            ),
          )
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
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
          allMovies.isEmpty
              ? const Center(child: CircularProgressIndicator(color: Colors.white))
              : pages[_selectedIndex],
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Colors.black12.withOpacity(0.15),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white.withOpacity(0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _navIcon(Icons.home_rounded, 0),
                  _navIcon(Icons.movie_rounded, 1),
                  _navIcon(Icons.tv_rounded, 2),
                  _navIcon(Icons.bookmark_rounded, 3),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _navIcon(IconData icon, int idx) {
    final selected = _selectedIndex == idx;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = idx),
      child: Icon(
        icon,
        size: 28,
        color: selected ? accent : Colors.white,
      ),
    );
  }

  Widget _buildHomeContent(List<String> categories) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 80),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: BannerCarousel(banners: allMovies.take(5).toList()),
        ),
        const SizedBox(height: 12),
        for (final cat in categories)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cat,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: allMovies.where((m) => m.category == cat).length,
                    itemBuilder: (context, index) {
                      final movie = allMovies.where((m) => m.category == cat).toList()[index];
                      return GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MovieDetailScreen(movie: movie, allMovies: allMovies),
                          ),
                        ),
                        child: Container(
                          width: 110,
                          margin: const EdgeInsets.only(right: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Expanded(
                                      child: CachedNetworkImage(
                                        imageUrl: movie.thumbnailUrl,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.red),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        movie.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
