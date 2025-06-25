import 'dart:convert';
import 'dart:ui';
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

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
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
    super.build(context);
    final categories = allMovies.map((m) => m.category).toSet().toList();
    final pages = [
      _buildHomeContent(categories),
      DownloadsScreen2(allMovies: allMovies),
      const WebSeriesScreen(),
      DownloadsScreen2(allMovies: allMovies),
    ];

    return Scaffold(
      extendBody: true,
      drawer: CustomDrawer(allMovies: allMovies),
      backgroundColor: navy,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [navy, navy],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
        ),
        surfaceTintColor: navy,
        backgroundColor: navy,
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
              MaterialPageRoute(
                builder: (_) => SearchScreen(allMovies: allMovies),
              ),
            ),
          ),
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
      child: Icon(icon, size: 28, color: selected ? accent : Colors.white),
    );
  }

  Widget _buildHomeContent(List<String> categories) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: categories.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 9),
            child: BannerCarousel(banners: allMovies.take(5).toList()),
          );
        }
        final cat = categories[index - 1];
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: _buildCategorySection(cat),
        );
      },
    );
  }

  Widget _buildCategorySection(String category) {
    final filteredMovies = allMovies.where((m) => m.category == category).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              category,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => GenreViewAllScreen(
                    genre: category,
                    movies: filteredMovies,
                  ),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white.withOpacity(0.2)),
                ),
                child: Row(
                  children: const [
                    Text(
                      'View All',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_outlined, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 180,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filteredMovies.length,
            separatorBuilder: (_, __) => const SizedBox(width: 5),
            itemBuilder: (context, index) {
              final movie = filteredMovies[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailScreen(movie: movie, allMovies: allMovies),
                  ),
                ),
                child: Container(
                  width: 111,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: movie.thumbnailUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error, color: Colors.red),
                          ),
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
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
