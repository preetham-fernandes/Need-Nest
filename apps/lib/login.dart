import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          // Allows scrolling for smaller screens
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _header(),
              const SizedBox(height: 20),
              _inputField("Username", Icons.person, false),
              const SizedBox(height: 10),
              _inputField("Email", Icons.email, false),
              const SizedBox(height: 10),
              _inputField("Password", Icons.lock, true),
              const SizedBox(height: 10),
              _signupButton(context),
              const SizedBox(height: 10),
              _loginLink(context),
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
          "Account Login",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        Text("Fill in the details to sign up"),
      ],
    );
  }

  Widget _inputField(String hintText, IconData icon, bool isObscure) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.purple.withOpacity(0.1),
        filled: true,
        prefixIcon: Icon(icon),
      ),
      obscureText: isObscure,
    );
  }

  Widget _signupButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle signup logic here
      },
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        backgroundColor: Colors.purple,
      ),
      child: const Text(
        "Login",
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget _loginLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account? "),
        TextButton(
          onPressed: () {
            // Navigate back to login or home page
            Navigator.pop(context);
          },
          child: const Text(
            "Log In",
            style: TextStyle(color: Colors.purple),
          ),
        ),
      ],
    );
  }
}
