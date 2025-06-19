import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/movies.dart';

class BannerCarousel extends StatelessWidget {
  final List<Movie> banners;
  const BannerCarousel({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("New Releases:", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0, ),textAlign: TextAlign.left,),
        CarouselSlider(
          options: CarouselOptions(
            height: 170,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1.0,
            aspectRatio: 16 / 9,
          ),
          items: banners.map((movie) {
            return Builder(
              builder: (context) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    movie.bannerUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.error)),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
