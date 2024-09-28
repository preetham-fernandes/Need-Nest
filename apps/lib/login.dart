import 'package:apps/landingpage.dart';
import 'package:apps/signup.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore package
import 'carepage.dart'; // Your CarePage

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _errorMessage = '';

  // Function to handle login by checking credentials in Firestore
  Future<void> _login(BuildContext context) async {
    String inputEmail = _emailController.text.trim();
    String inputPassword = _passwordController.text.trim();

    try {
      // Fetch user data from Firestore by email
      QuerySnapshot querySnapshot = await _firestore
          .collection('Volunteer') // Your Firestore collection
          .where('email', isEqualTo: inputEmail)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var userDoc = querySnapshot.docs.first;
        var storedPassword = userDoc['password'];

        // Compare the inputted password with the stored password
        if (storedPassword == inputPassword) {
          // Navigate to CarePage if password is correct
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LandingPage()),
          );
        } else {
          setState(() {
            _errorMessage = 'Incorrect password. Please try again.';
          });
        }
      } else {
        setState(() {
          _errorMessage = 'No account found with that email.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again later.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50], // Light background color
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 60), // Extra space at the top
              _header(),
              const SizedBox(height: 20),
              _inputField(
                  "Email", Icons.email_outlined, false, _emailController),
              const SizedBox(height: 10),
              _inputField(
                  "Password", Icons.lock_outline, true, _passwordController),
              const SizedBox(height: 10),
              _errorMessage.isNotEmpty
                  ? Text(
                      _errorMessage,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox.shrink(),
              const SizedBox(height: 20),
              _loginButton(context),
              const SizedBox(height: 10),
              _googleLoginButton(context),
              const SizedBox(height: 10),
              _signupLink(context),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      children: const [
        Text(
          "Sign in",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        Text("Login using your credentials", style: TextStyle(fontSize: 18)),
      ],
    );
  }

  Widget _inputField(String hintText, IconData icon, bool isObscure,
      TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.purple.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(icon, color: Colors.purple),
      ),
      obscureText: isObscure,
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        _login(context); // Call login function
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 60),
        backgroundColor: Colors.purple,
      ),
      child: const Text(
        "Sign in",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  Widget _googleLoginButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {
        // Handle Google sign-in logic here
      },
      icon: const Icon(Icons.login, color: Colors.purple),
      label: const Text("Sign in with Google"),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        side: const BorderSide(color: Colors.purple),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textStyle: const TextStyle(fontSize: 18, color: Colors.purple),
      ),
    );
  }

  Widget _signupLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SignupPage()),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.purple),
          ),
        ),
      ],
    );
  }
}
