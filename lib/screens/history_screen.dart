import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> bookings = [
    {
      "museum": "Museum of Art",
      "date": "01/05/2025",
      "adults": 2,
      "children": 1,
      "camera": true,
      "total": 3800
    },
    {
      "museum": "History Museum",
      "date": "25/04/2025",
      "adults": 1,
      "children": 0,
      "camera": false,
      "total": 1500
    },
  ];

  HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booking History"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        itemCount: bookings.length,
        itemBuilder: (context, index) {
          final booking = bookings[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("🎟️ ${booking['museum']}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text("📅 Date: ${booking['date']}"),
                  Text("👨 Adults: ${booking['adults']}"),
                  Text("🧒 Children: ${booking['children']}"),
                  Text("📸 Camera: ${booking['camera'] ? 'Yes' : 'No'}"),
                  const SizedBox(height: 8),
                  Text("💰 Total: ₹${booking['total']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green[700])),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
