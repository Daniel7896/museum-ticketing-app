import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/home_screen.dart'; // Import the HomeScreen file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Museum Ticketing', // The title of the app
      theme: ThemeData(
        primarySwatch: Colors.blue, // Primary color of the app
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),  // Updated text style for display large
          bodyLarge: TextStyle(fontSize: 16), // Updated body text style
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Colors.amber[700], // Button color customization
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Button shape
        ),
        scaffoldBackgroundColor: Colors.white, // General background color
        appBarTheme: AppBarTheme(
          color: Colors.blue, // AppBar color
          titleTextStyle: TextStyle(color: Colors.white), // Title text style in AppBar
        ),
      ),
      supportedLocales: [
        Locale('en', 'US'),  // English language (US)
        Locale('ta', 'IN'),  // Tamil language (India)
      ],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // Add any other delegates if needed for localization (e.g., custom)
      ],
      home: SplashScreen(), // Start with the splash screen
    );
  }
}

// Splash Screen: Display a welcome message and navigate to HomeScreen after 3 seconds
class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  // Navigation after 3 seconds to HomeScreen
  _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3)); // Wait for 3 seconds before navigating
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()), // Navigate to HomeScreen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,  // Splash Screen background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(  // Add a loading spinner
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Museum Ticketing',  // Title text on the Splash Screen
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
