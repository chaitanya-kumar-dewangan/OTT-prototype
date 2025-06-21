// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:ott/screens/home_screens.dart';
// import 'package:ott/screens/web_series_screen.dart';
// import '../models/movies.dart';
// import '../screens/categories.dart';
// import 'downloads.dart'; // Ensure this path is correct
//
// class CustomDrawer extends StatelessWidget {
//   final List<Movie> allMovies;
//
//   const CustomDrawer({super.key, required this.allMovies});
//
//   static const Color navy = Color(0xFF001F3F);
//   static const Color darkRed = Color(0xFF8B0000);
//   static const Color accent = Color(0xFFE50914);
//
//   Widget _glassTile({
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//     Color iconColor = Colors.white,
//     Color textColor = Colors.white,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(20),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
//           child: Container(
//             decoration: BoxDecoration(
//               color: Colors.white.withOpacity(0.08),
//               borderRadius: BorderRadius.circular(20),
//               border: Border.all(color: Colors.white.withOpacity(0.2)),
//             ),
//             child: ListTile(
//               leading: Icon(icon, color: iconColor),
//               title: Text(title, style: TextStyle(color: textColor)),
//               onTap: onTap,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               navy.withOpacity(0.5),
//               darkRed.withOpacity(0.6),
//               navy.withOpacity(0.6),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             const DrawerHeader(
//               decoration: BoxDecoration(color: Colors.transparent),
//               child: Image(
//                 image: AssetImage("assets/drawer/logo2.png"),
//                 height: 40.0,
//               ),
//             ),
//             _glassTile(
//               icon: Icons.home,
//               title: 'Home',
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
//               },
//             ),
//             _glassTile(
//               icon: Icons.category,
//               title: 'Categories',
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => CategoriesScreen(allMovies: allMovies)),
//                 );
//               },
//             ),
//             _glassTile(
//               icon: Icons.live_tv_sharp,
//               title: 'Web Series',
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(context, MaterialPageRoute(builder: (_) => const WebSeriesScreen()));
//               },
//             ),
//             _glassTile(
//               icon: Icons.download,
//               title: 'Downloads',
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => DownloadsScreen(allMovies: allMovies)),
//                 );
//               },
//             ),
//             _glassTile(
//               icon: Icons.bookmark,
//               title: 'Saved',
//               onTap: () {
//                 Navigator.pop(context);
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (_) => DownloadsScreen2(allMovies: allMovies)),
//                 );
//               },
//             ),
//             _glassTile(
//               icon: Icons.settings,
//               title: 'Settings',
//               onTap: () {
//                 Navigator.pop(context);
//               },
//             ),
//             _glassTile(
//               icon: Icons.logout,
//               title: 'Logout',
//               iconColor: Colors.red,
//               textColor: Colors.red,
//               onTap: () {
//                 Navigator.pop(context);
//                 // Add logout logic here
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ott/screens/home_screens.dart';
import 'package:ott/screens/web_series_screen.dart';
import '../models/movies.dart';
import '../screens/categories.dart';
import 'downloads.dart'; // Ensure this path is correct

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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: ListTile(
              leading: Icon(icon, color: iconColor),
              title: Text(title, style: TextStyle(color: textColor)),
              onTap: onTap,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Stack(
        children: [
          // Background glass gradient
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
          // Blur effect
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
            child: Container(
              color: Colors.transparent, // Important for blur visibility
              child: ListView(
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
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const WebSeriesScreen()));
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
                        MaterialPageRoute(builder: (_) => DownloadsScreen2(allMovies: allMovies)),
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
            ),
          ),
        ],
      ),
    );
  }
}
