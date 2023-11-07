import 'package:flutter/material.dart';

class OrnamentImage extends StatelessWidget {
  const OrnamentImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Image.asset('assets/ornament.jpg', width: 30, height: 30),
    );
  }
}
