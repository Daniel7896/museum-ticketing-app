import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.amber[700],
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // You can add navigation to an edit profile screen if required.
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Image
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile_picture.jpg'), // Update with your profile image
              ),
            ),
            const SizedBox(height: 16),

            // User Name
            const Center(
              child: Text(
                "John Doe", // Replace with dynamic user data
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Tamil', // Use your custom font if needed
                ),
              ),
            ),
            const SizedBox(height: 8),

            // User Information
            const Text(
              "Email: johndoe@example.com", // Replace with dynamic email
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            const Text(
              "Phone: +1 234 567 890", // Replace with dynamic phone number
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

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
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
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
