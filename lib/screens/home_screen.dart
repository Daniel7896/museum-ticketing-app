import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:museum_ticketing_app/screens/booking_screen.dart';
import 'package:museum_ticketing_app/screens/chatbot_screen.dart';
import 'package:museum_ticketing_app/screens/explore_screen.dart';
import 'package:museum_ticketing_app/screens/history_screen.dart';
import 'package:museum_ticketing_app/screens/profile_screen.dart';
import 'package:museum_ticketing_app/screens/exhibition_detail_screen.dart';  // New import for ExhibitionDetailScreen

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Tracks the current tab index
  final PageController _pageController = PageController();

  // All tab pages used in PageView
  final List<Widget> _pages = [
    const HomePageContent(),       // Home tab content
    const ExploreScreen(),         // Explore screen
    HistoryScreen(),         // History screen
    const ProfileScreen(),         // Profile screen
  ];

  // Handle tab change from bottom nav
  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex == 0 ? _buildAppBar() : null, // Only show AppBar on Home tab
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Prevent swiping tabs
        children: _pages,
      ),
      floatingActionButton:
          _selectedIndex == 0 ? _buildChatbotButton(context) : null,
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // Top AppBar with Logo and Title
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF5C6BC0), // Deep blue background color
      title: Row(
        children: [
          SvgPicture.asset('assets/images/logo.svg', height: 30),
          const SizedBox(width: 10),
          const Text('Tamil Nadu Museum',
              style: TextStyle(fontFamily: 'Tamil', fontSize: 18, color: Colors.white)),
        ],
      ),
      actions: [
        IconButton(icon: const Icon(Icons.notifications, color: Colors.white), onPressed: () {}),
      ],
    );
  }

  // Bottom navigation for switching tabs
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.amber[700],
      unselectedItemColor: Colors.grey[600],
      backgroundColor: const Color(0xFF3F51B5), // Deep blue background
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }

  // Chatbot button only on Home tab
  Widget _buildChatbotButton(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.amber[700],
      child: const Icon(Icons.chat, color: Colors.white),
      onPressed: () => Navigator.push(
          context, MaterialPageRoute(builder: (_) => const ChatbotScreen())),
    );
  }
}

// --------------------
// HomePageContent Widget
// This holds the actual content of the Home tab
// --------------------

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildCulturalBanner(),
          _buildQuickActions(context),
          _buildCurrentExhibitions(context), // Pass context to exhibitions
          _buildMuseumHighlights(),
        ],
      ),
    );
  }

  // Banner with background image
  Widget _buildCulturalBanner() {
    return Container(
      height: 180,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/banner.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: const Center(
        child: Text('Welcome!',
            style: TextStyle(
                fontFamily: 'Tamil',
                fontSize: 32,
                color: Colors.white,
                shadows: [Shadow(blurRadius: 8, color: Colors.black)])),
      ),
    );
  }

  // Quick action buttons like Tickets, History, Guide
  Widget _buildQuickActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(Icons.confirmation_num, 'Tickets',
              () => Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const BookingScreen()))),
          _buildActionButton(Icons.history, 'History', () {}),
          _buildActionButton(Icons.audio_file, 'Guide', () {}),
        ],
      ),
    );
  }

  // Single Quick Action Button
  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: const Color(0xFF5C6BC0), // Deep blue for buttons
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))
              ],
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontFamily: 'Tamil', color: Colors.black)),
        ],
      ),
    );
  }

  // List of current exhibitions
  Widget _buildCurrentExhibitions(BuildContext context) {
    final exhibitions = [
      {
        'title': 'Chola Art',
        'location': 'Thanjavur',
        'price': '₹50',
        'image': 'assets/images/exhibition_chola.jpg',
        'description': 'Explore the rich art of the Chola dynasty.'
      },
      {
        'title': 'Pallava Sculptures',
        'location': 'Mahabalipuram',
        'price': '₹75',
        'image': 'assets/images/exhibition_pallava.jpg',
        'description': 'Discover the masterpieces of Pallava sculpting.'
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text('Current Exhibitions',
              style: TextStyle(
                  fontFamily: 'Tamil',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F51B5))), // Deep blue color
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: exhibitions.length,
          itemBuilder: (ctx, index) =>
              _buildExhibitionCard(exhibitions[index], context), // Pass context to the card
        ),
      ],
    );
  }

  // Single exhibition card with image, title, location, price
  Widget _buildExhibitionCard(Map<String, String> exhibition, BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the Exhibition Detail Screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExhibitionDetailScreen(
              title: exhibition['title'] ?? 'No Title',
              location: exhibition['location'] ?? 'Unknown Location',
              description: exhibition['description'] ?? 'No description available',
              image: exhibition['image'] ?? 'assets/images/default_exhibition.jpg',
            ),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
                exhibition['image'] ?? 'assets/images/default_exhibition.jpg',
                width: 50,
                height: 50,
                fit: BoxFit.cover),
          ),
          title: Text(exhibition['title'] ?? 'No Title',
              style: const TextStyle(fontFamily: 'Tamil', fontSize: 16)),
          subtitle: Text(exhibition['location'] ?? 'Unknown Location',
              style: TextStyle(fontFamily: 'Tamil', color: Colors.grey[600])),
          trailing: Chip(
            backgroundColor: const Color(0xFF5C6BC0), // Deep blue chip color
            label: Text(exhibition['price'] ?? 'No Price',
                style: const TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  // Horizontal scroll of museum highlight items
  Widget _buildMuseumHighlights() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Museum Highlights',
              style: TextStyle(
                  fontFamily: 'Tamil',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3F51B5))), // Deep blue color
          const SizedBox(height: 10),
          SizedBox(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildHighlightItem(
                    'assets/images/highlight1.jpg', 'Ancient Coins'),
                _buildHighlightItem(
                    'assets/images/highlight2.jpg', 'Temple Sculptures'),
                _buildHighlightItem(
                    'assets/images/highlight3.jpg', 'Historical Manuscripts'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Single museum highlight item
  Widget _buildHighlightItem(String imagePath, String title) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(right: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(imagePath, width: 120, height: 120, fit: BoxFit.cover),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(title,
                style: const TextStyle(fontFamily: 'Tamil', fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
