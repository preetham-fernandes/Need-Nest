import 'package:flutter/material.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Mobile Number'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle form submission and update user data
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
