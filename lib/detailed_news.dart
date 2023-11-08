import 'package:flutter/material.dart';
import 'package:church_silz/news_section.dart';

class DetailedNewsPage extends StatelessWidget {
  final NewsItem newsItem;

  DetailedNewsPage({required this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Colors.grey.withOpacity(1.0), // Adjust the opacity and colors
                          Colors.grey.withOpacity(0.8), // to control the shade
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16,
                    ),
                    child: Text(
                      newsItem.date,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // Text color on the shaded background
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    newsItem.title,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFD2B48C),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    newsItem.description,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
