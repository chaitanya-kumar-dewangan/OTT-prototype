import 'dart:ui';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movies.dart';
import '../widgets/banner_carausel.dart';
import 'detail_screen.dart';
import 'download_screen2.dart';
import 'drawer.dart';
import 'genere_view_all-screen.dart';
import 'search_screen.dart';
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
      backgroundColor:                   navy.withOpacity(0.5),

      appBar: AppBar(

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

        surfaceTintColor:                  navy.withOpacity(0.5),

        backgroundColor:                  navy.withOpacity(0.5),

        // backgroundColor: Colors.transparent,
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
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
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
          padding: const EdgeInsets.symmetric(horizontal: 9),
          child: BannerCarousel(banners: allMovies.take(5).toList()),
        ),
        const SizedBox(height: 12),
        for (final cat in categories)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category title + View All in a Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      cat,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.08),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white.withOpacity(0.2)),
                          ),
                          child: GestureDetector(
                            onTap: () {
                              final filtered = allMovies.where((m) => m.category == cat).toList();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => GenreViewAllScreen(
                                    genre: cat,
                                    movies: filtered,
                                  ),
                                ),
                              );
                            },
                            child: Row(mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Text(
                                  'View All',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Icon(Icons.arrow_forward_ios_outlined, color: Colors.white,weight: 40,size: 18.0,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),


                  ],
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
                          width: 111,
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
                                        placeholder: (context, url) =>
                                        const Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                        const Icon(Icons.error, color: Colors.red),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        movie.title,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
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
