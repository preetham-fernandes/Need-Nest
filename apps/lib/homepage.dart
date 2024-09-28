import 'package:apps/signup.dart';
import 'package:flutter/material.dart';
import 'login.dart'; // Import the RegistrationPage file

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Background image
          Image.asset(
            'assets/background.jpg',
            fit: BoxFit.cover, // Cover the entire screen
            width: double.infinity, // Stretch to full width
            height: double.infinity, // Stretch to full height
          ),
          // Overlay content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Alone we can do so little.\nTogether we can do so much.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color:
                        Colors.white, // Change text color for better visibility
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to RegistrationPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupPage()),
                    );
                  },
                  child: Text('Create Account'),
                ),
                SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Handle "Log in" button press
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text(
                    'Already a member? Log in',
                    style: TextStyle(
                        color: Colors.white), // Change button text color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
