import 'package:flutter/material.dart';

class ChurchHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Church History'),
          centerTitle: true,
          backgroundColor: const Color(0xFFD2B48C),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(
                'Our Church History',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                    'Nullam ut semper ex. Integer venenatis libero at eros '
                    'porttitor, at facilisis felis tristique. Phasellus non '
                    'dolor in erat venenatis tincidunt. Proin sit amet nibh '
                    'eget nunc bibendum semper.',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Vivamus varius mi vel lectus convallis, ut scelerisque '
                    'velit facilisis. Vestibulum ante ipsum primis in faucibus '
                    'orci luctus et ultrices posuere cubilia Curae; Integer '
                    'ac varius leo. Suspendisse sollicitudin sapien nec ante '
                    'ullamcorper, quis lacinia orci varius.',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              // Continue adding more text as needed
            ],
          ),
        ),
      ),
    );
  }
}
