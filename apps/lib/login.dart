import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                  "Email or Mobile Number", Icons.email_outlined, false),
              const SizedBox(height: 10),
              _inputField("Password", Icons.lock_outline, true),
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
        prefixIcon: Icon(icon, color: Colors.purple),
      ),
      obscureText: isObscure,
    );
  }

  Widget _loginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Handle login logic here
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
            // Handle sign-up navigation
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
