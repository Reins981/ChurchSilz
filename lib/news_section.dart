// news_section.dart
import 'package:flutter/material.dart';
import 'package:church_silz/news_card.dart';
import 'package:church_silz/detailed_news.dart';

class NewsSection extends StatefulWidget {
  @override
  _NewsSectionState createState() => _NewsSectionState();
}

class _NewsSectionState extends State<NewsSection> {
  // Mock news data
  final List<NewsItem> newsItems = [
    NewsItem(
      title: 'News Title 1',
      description: 'Description of News Title 1. '
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
    'Nullam ut semper ex. Integer venenatis libero at eros '
    'porttitor, at facilisis felis tristique. Phasellus non '
    'dolor in erat venenatis tincidunt. Proin sit amet nibh '
    'eget nunc bibendum semper. Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
    'Nullam ut semper ex. Integer venenatis libero at eros '
    'porttitor, at facilisis felis tristique. Phasellus non '
    'dolor in erat venenatis tincidunt. Proin sit amet nibh '
    'eget nunc bibendum semper.',
      imageUrl: 'assets/news1.jpg',
      date: "10.03.2023",
    ),
    NewsItem(
      title: 'News Title 2',
      description: 'Description of News Title 2.',
      imageUrl: 'assets/news2.jpg',
      date: "04.06.2021",
    ),
    // Add more news items as needed
  ];

  int selectedNewsIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('Aktuelles'),
          centerTitle: true,
          backgroundColor: const Color(0xFFD2B48C),
        ),
        body: SingleChildScrollView (
          child: Column(
            children: [
              const SizedBox(height: 20),
              NewsSlider(
                newsItems: newsItems,
                onNewsSelected: (index) {
                  setState(() {
                    selectedNewsIndex = index;
                  });
                },
                selectedNewsIndex: selectedNewsIndex,
              ),
              const SizedBox(height: 20),
              if (selectedNewsIndex < newsItems.length)
                DetailedNewsPage(newsItem: newsItems[selectedNewsIndex]),
            ],
          ),
        ),
    );
  }
}

class NewsItem {
  final String title;
  final String description;
  final String imageUrl;
  final String date;

  NewsItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
  });
}

class NewsSlider extends StatelessWidget {
  final List<NewsItem> newsItems;
  final Function(int) onNewsSelected;
  final int selectedNewsIndex;

  NewsSlider({required this.newsItems, required this.onNewsSelected, required this.selectedNewsIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: newsItems.length,
        controller: PageController(
            initialPage: selectedNewsIndex,
            viewportFraction: (newsItems.length > 2) ? 0.5: 0.9,
        ),
        onPageChanged: onNewsSelected,
        itemBuilder: (context, index) {
          return NewsCard(
            newsItem: newsItems[index],
          );
        },
      ),
    );
  }
}

