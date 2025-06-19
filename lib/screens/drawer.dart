import 'package:flutter/material.dart';
import 'package:ott/screens/home_screens.dart';
import '../models/movies.dart';
import '../screens/categories.dart';
import 'downloads.dart'; // Make sure path is correct

class CustomDrawer extends StatelessWidget {
  final List<Movie> allMovies;

  const CustomDrawer({super.key, required this.allMovies});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.black45),
            child: Image.asset("assets/drawer/logo2.png", height: 40.0),
          ),

          // Home
          ListTile(
            leading: const Icon(Icons.home, color: Colors.white),
            title: const Text('Home', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // Close drawer first
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeScreen(),
                ),
              );
            }
            // onTap: () => Navigator.pop(context),
          ),

          // Categories
          ListTile(
            leading: const Icon(Icons.category, color: Colors.white),
            title: const Text('Categories', style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context); // Close drawer first
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoriesScreen(allMovies: allMovies),
                ),
              );
            },
          ),

          // Downloads
          ListTile(
            leading: const Icon(Icons.download, color: Colors.white),
            title: const Text('Downloads', style: TextStyle(color: Colors.white)),
            // onTap: () {},
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DownloadsScreen(allMovies: allMovies),
                ),
              );
            },
          ),

          // Saved
          ListTile(
            leading: const Icon(Icons.bookmark, color: Colors.white),
            title: const Text('Saved', style: TextStyle(color: Colors.white)),
            // onTap: () {},
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => DownloadsScreen2(allMovies: allMovies),
                ),
              );
            },
          ),

          // Settings
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.white),
            title: const Text('Settings', style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),

          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              // TODO: Add logout logic here
            },
          ),
        ],
      ),
    );
  }
}
