import 'package:flutter/material.dart';
import 'package:bancofinandina/carousel/view_carousel.dart';
import '../dataSource/info_pages.dart';

class CarouselState extends StatefulWidget {
  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<CarouselState> {
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < pages.length - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentPage,
        children: pages.map((page) {
          return ViewCarousel(
              background: page['background'],
              title: page['title'] ?? '',
              subtitle: page['subtitle'] ?? '',
              parraf: page['parraf'] ?? '',
              image: page['image'] ?? '',
              size: page['size'] ?? '',
              onNextPage: _nextPage,
              end: page['end'] == "end" ? true : false,
              currentPage: _currentPage);
        }).toList(),
      ),
    );
  }
}
