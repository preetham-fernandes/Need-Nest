import 'package:flutter/material.dart';
import 'userprofilepage.dart'; // Import the UserProfilePage
import 'searchbarpage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0; // Track the current index

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });

    if (index == 0) {
      // Navigate back to home page (LandingPage)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingPage()),
      );
    } else if (index == 1) {
      // Navigate to profile page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Marcus', // Volunteer name
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Super bold font
                          fontSize: 22, // Larger font size for emphasis
                          color: Colors.black87, // White color to match appBar
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wide search bar with magnifying glass icon
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SearchBarPage()),
                  );
                },
                child: IgnorePointer(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search...',
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                    ),
                    enabled: false,
                  ),
                ),
              ),
            ),

            // Profile section with CircleAvatar
            Padding(
              padding: const EdgeInsets.all(2.50),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('../assets/kids.jpg'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'More people, more impact.',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Let\'s help the community together!',
                              style: TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                minimumSize: const Size.fromHeight(40),
                              ),
                              child: const Text('Get Involved'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Recommended For You section
            _buildSection(
              'Recommended For You',
              [
                _buildCauseRow('../assets/kids.jpg', 'Volunteer', '10 hours'),
                _buildCauseRow('../assets/ferris.jpg', 'Volunteer', '15 hours'),
                _buildCauseRow('../assets/ferris.jpg', 'Volunteer', '12 hours'),
              ],
            ),

            // Upcoming events section
            _buildSection(
              'Upcoming Events',
              [
                _buildEventRow(
                    '../assets/kids.jpg', 'Event Name 1', 'Oct 10, 2024'),
                _buildEventRow(
                    '../assets/ferris.jpg', 'Event Name 2', 'Oct 15, 2024'),
              ],
            ),

            // Partner organizations section
            _buildSection(
              'Partner Organizations',
              [
                _buildPartnerRow('../assets/kids.jpg', 'Organization 1',
                    'Helping kids in need'),
                _buildPartnerRow('../assets/ferris.jpg', 'Organization 2',
                    'Environmental Conservation'),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Set the current index
        onTap: _onItemTapped, // Set the onTap function
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...children.map((child) => Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: child,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCauseRow(String imagePath, String title, String hours) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(hours),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventRow(String imagePath, String eventName, String date) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(eventName,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(date),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPartnerRow(
      String imagePath, String partnerName, String description) {
    return Container(
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(imagePath, fit: BoxFit.cover),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(partnerName,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(description),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
