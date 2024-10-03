import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'userprofilepage.dart'; // Import the UserProfilePage
import 'searchbarpage.dart';
import 'userlistpage.dart';
import 'eventdetailspage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _currentIndex = 0; // Track the current index
  String volunteerName = ''; // Variable to hold the volunteer's name

  @override
  void initState() {
    super.initState();
    fetchVolunteerName();
  }

  Future<void> fetchVolunteerName() async {
    String userId =
        'user_id'; // Replace with the actual user ID obtained after login

    DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('Volunteer') // Replace with your users collection
        .doc(userId)
        .get();

    if (snapshot.exists) {
      setState(() {
        volunteerName = snapshot['name']; // Adjust the field name as necessary
      });
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index; // Update the current index
    });
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LandingPage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserProfilePage()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const UserListPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        volunteerName.isNotEmpty ? volunteerName : 'Loading...',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: Colors.black87,
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
            icon: const Icon(Icons.notification_important),
            onPressed: () {},
          ),
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
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: const DecorationImage(
                      image:
                          AssetImage('../assets/kids.jpg'), // Background image
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'More people, more impact.',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 5),
                            const Text(
                              'Let\'s help the community together!',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 5, // Add shadow
                                backgroundColor: Colors.transparent,
                              ),
                              child: Ink(
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Colors.blueAccent,
                                      Colors.lightBlueAccent,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Container(
                                  constraints: const BoxConstraints(
                                      maxWidth: 150,
                                      minHeight: 50), // Set width and height
                                  alignment: Alignment.center,
                                  child: const Text(
                                    'Get Involved',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Upcoming Events (Dynamic from Firestore)
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Alerts')
                  .where('status', isEqualTo: 'open')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(child: Text('No available alerts'));
                }

                final upcomingEvents = snapshot.data!.docs;

                return _buildSection(
                  'Upcoming Events',
                  upcomingEvents.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final eventDate =
                        (data['dateTime'] as Timestamp?)?.toDate();
                    return Container(
                      margin: const EdgeInsets.only(
                          bottom: 2), // Margin at the bottom of each card
                      child: _buildEventRow(
                        data['imageUrl'] ??
                            '../assets/kids.jpg', // Image URL from Firestore or default image
                        data['title'] ?? 'Event Name',
                        eventDate != null
                            ? '${eventDate.day}/${eventDate.month}/${eventDate.year}'
                            : 'Unknown Date',
                        data['description'] ?? '',
                        data['mapImage'] ?? '../assets/map.jpg',
                        data['url'] ?? 'https://shorturl.at/nsOmI',
                        data['address'] ?? '',
                        data['compensation'] ?? '',
                      ),
                    );
                  }).toList(),
                );
              },
            ),

            // Display all alerts below Upcoming Events
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Alerts').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final allAlerts = snapshot.data!.docs;

                return _buildSection(
                  'All Alerts',
                  allAlerts.map((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return _buildCauseRow(
                      data['imageUrl'] ??
                          '../assets/kids.jpg', // Dummy image for alerts
                      data['title'] ?? 'Alert Title',
                      '${data['duration'] ?? '0'} hours',
                      data['description'] ?? '',
                      data['mapImage'] ?? '../assets/map2.jpg',
                      data['url'] ?? '',
                      data['address'] ?? '',
                      data['compensation'] ?? '',
                    );
                  }).toList(),
                );
              },
            ),

            // Partner organizations section (Static)
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
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble), label: 'Community'),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Column(children: children),
        ],
      ),
    );
  }

  Widget _buildEventRow(
      String imageUrl,
      String title,
      String date,
      String description,
      String mapImage,
      String url,
      String address,
      String compensation) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(
              title: title,
              text: description,
              imageUrl: imageUrl,
              mapImage: mapImage,
              url: url,
              address: address,
              compensation: compensation,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.network(imageUrl,
                  width: 100, height: 100, fit: BoxFit.cover),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(date, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCauseRow(
    String imageUrl,
    String title,
    String duration,
    String description,
    String mapImage,
    String url,
    String address,
    String compensation,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EventDetailsPage(
              title: title,
              text: description,
              imageUrl: imageUrl,
              mapImage: mapImage,
              url: url,
              address: address,
              compensation: compensation,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Image.network(imageUrl,
                  width: 100, height: 100, fit: BoxFit.cover),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 5),
                    Text(duration, style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPartnerRow(String imageUrl, String title, String description) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(imageUrl, width: 100, height: 100, fit: BoxFit.cover),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text(description, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
