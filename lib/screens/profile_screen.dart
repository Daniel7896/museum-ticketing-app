import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.amber[700],
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // You can add navigation to an edit profile screen if required.
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_picture.jpg'), // Update with your profile image
              ),
            ),
            SizedBox(height: 16),

            // User Name
            Center(
              child: Text(
                "John Doe", // Replace with dynamic user data
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tamil', // Use your custom font if needed
                ),
              ),
            ),
            SizedBox(height: 8),

            // User Information
            Text(
              "Email: johndoe@example.com", // Replace with dynamic email
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              "Phone: +1 234 567 890", // Replace with dynamic phone number
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),

            // Action Buttons (e.g., View Past Bookings, Settings, etc.)
            _buildActionButton(context, Icons.history, "Booking History", () {
              // Add action to view booking history
            }),
            _buildActionButton(context, Icons.settings, "Settings", () {
              // Add action to open settings
            }),
          ],
        ),
      ),
    );
  }

  // Helper function for creating action buttons
  Widget _buildActionButton(
      BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: Colors.amber[700], size: 24),
            SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
