import 'package:flutter/material.dart';
import 'chatpage.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Add search functionality here
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8.0),
        children: [
          _buildUserListTile(context, 'Shane Martinez', '5 min', true),
          _buildUserListTile(context, 'Katie Keller', '15 min', false),
          _buildUserListTile(context, 'Stephen Mann', '1 hour', true),
          _buildUserListTile(context, 'Melvin Pratt', '5 hours', false),
          _buildUserListTile(context, 'Jessica Simmons', '10 min', true),
          _buildUserListTile(context, 'David Robertson', '30 min', false),
        ],
      ),
    );
  }

  // Helper function to create the user list tile
  Widget _buildUserListTile(
      BuildContext context, String name, String time, bool isActive) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(name[0]), // First letter of the name as avatar
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text('$time | ${isActive ? "Active" : "Inactive"}'),
      onTap: () {
        // Navigate to ChatPage on user tap
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ChatPage(userName: name), // Pass user name to ChatPage
          ),
        );
      },
    );
  }
}
