import 'package:flutter/material.dart';

class ExhibitionDetailScreen extends StatelessWidget {
  final String title;
  final String location;
  final String description;
  final String image;

  // Constructor to accept data when navigating to this screen
  ExhibitionDetailScreen({
    required this.title,
    required this.location,
    required this.description,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Displaying the exhibition image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(image, width: double.infinity, height: 250, fit: BoxFit.cover),
            ),
            SizedBox(height: 16),
            Text(
              location,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}
