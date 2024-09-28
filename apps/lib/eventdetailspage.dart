import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetailsPage extends StatelessWidget {
  final String title;
  final String text;
  final String imageUrl;
  final String mapImage;
  final String url;
  final String address;
  final String compensation;
// New parameter for event time

  const EventDetailsPage({
    Key? key,
    required this.title,
    required this.text,
    required this.imageUrl,
    required this.mapImage,
    required this.url,
    required this.address,
    required this.compensation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    text,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Location:',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Image.network(mapImage),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      launchUrl(url); // Use the updated method
                    },
                    child: const Text('View Location'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    address,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Compensation:',
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    compensation,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _showSuccessDialog(context);
                    },
                    child: const Text('Register Now'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void launchUrl(String url) async {
    // Check if the URL can be launched
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Registration Successful'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Event: $title'),
              Text('Address: $address'),
              Text('Location:'),
              Image.network(mapImage), // Show the map image as well
            ],
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
