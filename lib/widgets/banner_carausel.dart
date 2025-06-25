import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../models/movies.dart';

class BannerCarousel extends StatelessWidget {
  final List<Movie> banners;

  const BannerCarousel({super.key, required this.banners});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
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
              child: CachedNetworkImage(
                imageUrl: movie.bannerUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) => Container(
                  color: Colors.black26,
                  child: const Center(child: CircularProgressIndicator(color: Colors.white)),
                ),
                errorWidget: (context, url, error) => const Center(
                  child: Icon(Icons.error, color: Colors.white),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
