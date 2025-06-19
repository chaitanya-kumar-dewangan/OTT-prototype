import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ott/screens/downloads.dart';
import 'package:ott/screens/web_series_screen.dart';
import '../models/movies.dart';
import '../widgets/banner_carausel.dart';
import '../widgets/category_section.dart';
import 'detail_screen.dart';
import 'drawer.dart';
import 'search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> allMovies = [];
  int _selectedIndex = 0;

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

  @override
  Widget build(BuildContext context) {
    final categories = allMovies.map((m) => m.category).toSet().toList();

    final List<Widget> pages = [
      _buildHomeContent(categories),
      DownloadsScreen2(allMovies: allMovies),
      // const Center(
      //   child: Text('Web Series', style: TextStyle(color: Colors.white)),
      // ),
      WebSeriesScreen(),
      DownloadsScreen2(allMovies: allMovies),
    ];

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      drawer: CustomDrawer(allMovies: allMovies),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchScreen(allMovies: allMovies),
              ),
            );
          },
          child: AbsorbPointer(
            child: TextField(
              readOnly: true,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search movies...',
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white10,
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: const Icon(Icons.search, color: Colors.white70),
              ),
            ),
          ),
        ),
      ),
      body: allMovies.isEmpty
          ? const Center(child: CircularProgressIndicator(color: Colors.yellow))
          : pages[_selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 3.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 60,
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
    );
  }

  Widget _buildNavIcon(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Icon(
        icon,
        size: 28,
        color: isSelected ? Colors.yellow : Colors.white70,
      ),
    );
  }

  Widget _buildHomeContent(List<String> categories) {
    return ListView(
      padding: const EdgeInsets.only(bottom: 60),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: BannerCarousel(banners: allMovies.take(5).toList()),
        ),
        const SizedBox(height: 8),
        for (final category in categories)
          CategorySection(
            title: category,
            movies: allMovies.where((m) => m.category == category).toList(),
            onMovieTap: (movie) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      MovieDetailScreen(movie: movie, allMovies: allMovies),
                ),
              );
            },
          ),
      ],
    );
  }
}
