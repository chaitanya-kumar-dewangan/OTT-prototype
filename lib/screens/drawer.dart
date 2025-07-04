import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ott/screens/home_screens.dart';
import 'package:ott/screens/saved_drawer.dart';
import 'package:ott/screens/webseries_2.dart';
import '../models/movies.dart';
import '../screens/categories.dart';
import 'download_screen_drawer.dart';

class CustomDrawer extends StatelessWidget {
  final List<Movie> allMovies;

  const CustomDrawer({super.key, required this.allMovies});

  static const Color navy = Color(0xFF001F3F);
  static const Color darkRed = Color(0xFF8B0000);
  static const Color accent = Color(0xFFE50914);

  Widget _glassTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = Colors.white,
    Color textColor = Colors.white,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.06),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.15)),
        ),
        child: ListTile(
          leading: Icon(icon, color: iconColor),
          title: Text(title, style: TextStyle(color: textColor)),
          onTap: onTap,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  navy.withOpacity(0.3),
                  darkRed.withOpacity(0.4),
                  navy.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Global Backdrop Blur
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(
              color: Colors.black.withOpacity(0.15),
            ),
          ),
          // Drawer content
          ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.transparent),
                child: Image(
                  image: AssetImage("assets/drawer/logo2.png"),
                  height: 40.0,
                ),
              ),
              _glassTile(
                icon: Icons.home,
                title: 'Home',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
                },
              ),
              _glassTile(
                icon: Icons.category,
                title: 'Categories',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CategoriesScreen(allMovies: allMovies)),
                  );
                },
              ),
              _glassTile(
                icon: Icons.live_tv_sharp,
                title: 'Web Series',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const WebSeriesScreen2()));
                },
              ),
              _glassTile(
                icon: Icons.download,
                title: 'Downloads',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DownloadsScreen(allMovies: allMovies)),
                  );
                },
              ),
              _glassTile(
                icon: Icons.bookmark,
                title: 'Saved',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SavedDrawer(allMovies: allMovies)),
                  );
                },
              ),
              _glassTile(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              _glassTile(
                icon: Icons.logout,
                title: 'Logout',
                iconColor: Colors.red,
                textColor: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  // Add logout logic here
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
