import 'package:flutter/material.dart';
import 'landingpage.dart'; // Import the LandingPage

class CausesPage extends StatefulWidget {
  const CausesPage({super.key});

  @override
  _CausesPageState createState() => _CausesPageState();
}

class _CausesPageState extends State<CausesPage> {
  final List<String> causes = [
    "Advocacy",
    "Animals",
    "Arts",
    "Children",
    "Disabilities",
    "Disaster Recovery",
    "Education",
    "Employment",
    "Environment",
    "Food Access",
    "Health",
    "Homelessness",
    "LGBTQ",
    "Mental Health",
    "Mentoring",
    "Politics",
    "Seniors",
    "Sports & Recreation",
    "Sustainability",
    "Technology",
    "Veterans",
    "Women",
  ];

  final List<bool> _selectedCauses = List.filled(23, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('What causes do you care about?'),
        actions: [
          TextButton(
            onPressed: () {
              // Handle skip
            },
            child: const Text('Skip'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: causes.map((cause) {
                return ChoiceChip(
                  label: Text(cause),
                  selected: _selectedCauses[causes.indexOf(cause)],
                  onSelected: (bool selected) {
                    setState(() {
                      _selectedCauses[causes.indexOf(cause)] = selected;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to LandingPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LandingPage()),
                );
              },
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
