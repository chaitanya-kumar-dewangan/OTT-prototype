import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ott/screens/home_screens.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CinestreamX',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class GradientBackgroundScreen extends StatelessWidget {
  const GradientBackgroundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color darkPurple = Color(0xFF4B099); // Indigo/Dark Purple
    const Color black = Color(0xFF000000);      // Black

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [darkPurple, black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: const Center(
          child: Text(
            'Gradient Background',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
