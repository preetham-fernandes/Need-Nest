import 'package:flutter/material.dart';
import 'editprofile.dart'; // Make sure this import is correct

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marcus Bane'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('../assets/ferris.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Marcus Bane',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          '33 Hours\nVolunteer Activities',
                          style: TextStyle(fontSize: 14),
                        ),
                        const Text(
                          '41 Friends',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(
                            height: 20), // Add space before the button
                        ElevatedButton(
                          onPressed: () {
                            // Navigate to EditProfilePage
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const EditProfilePage()),
                            );
                          },
                          child: const Text('Edit Profile'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),

            // Upcoming Events Section
            _buildSectionTitle('Your Upcoming Events'),
            _buildEventCard(
                '../assets/ferris.jpg', 'Event Name 1', 'Oct 10, 2024'),
            _buildEventCard(
                '../assets/ferris.jpg', 'Event Name 2', 'Oct 15, 2024'),
            const SizedBox(height: 16),
            const Divider(),

            // Followed Organizations Section
            _buildSectionTitle('Followed Organizations'),
            _buildOrganizationCard('../assets/ferris.jpg',
                'Organization Name 1', 'Helping kids in need'),
            _buildOrganizationCard('../assets/ferris.jpg',
                'Organization Name 2', 'Environmental Conservation'),
            const SizedBox(height: 16),
            const Divider(),

            // Causes Section
            _buildSectionTitle('Causes'),
            _buildCauseChips(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 0, // Set the current index based on your app logic
        selectedItemColor: Colors.blue, // Change color of the selected item
        unselectedItemColor: Colors.grey, // Change color of unselected items
        onTap: (index) {
          // Handle navigation on item tap
        },
      ),
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  // Helper method to build event cards
  Widget _buildEventCard(String imageUrl, String title, String date) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(date),
      ),
    );
  }

  // Helper method to build organization cards
  Widget _buildOrganizationCard(
      String logoUrl, String name, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(10.0),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset(
            logoUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
      ),
    );
  }

  // Helper method to build cause chips
  Widget _buildCauseChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        children: [
          ChoiceChip(
            label: const Text('Advocacy'),
            selected: false,
            onSelected: (bool selected) {
              // Handle cause selection
            },
          ),
          ChoiceChip(
            label: const Text('Community Service'),
            selected: false,
            onSelected: (bool selected) {
              // Handle cause selection
            },
          ),
          // Add more cause chips here
        ],
      ),
    );
  }
}
