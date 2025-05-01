import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Explore Exhibitions')),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search Exhibitions',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          // List of exhibitions (you can replace this with dynamic data)
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Exhibition #${index + 1}'),
                  subtitle: Text('Location #${index + 1}'),
                  onTap: () {
                    // Navigate to exhibition detail
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
