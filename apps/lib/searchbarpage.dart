import 'package:flutter/material.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({super.key});

  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _searchResults = [
    'Volunteer Opportunity: Meals on Wheels: Seattle/Belltown',
    'Volunteer Opportunity: Art & Design Program',
    // ... other search results
  ];

  bool _showResults = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: _showResults
                ? IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setState(() {
                        _showResults = false;
                        _searchController.clear();
                      });
                    },
                  )
                : null,
          ),
          onChanged: (value) {
            setState(() {
              _showResults = value.isNotEmpty;
            });
          },
        ),
      ),
      body: Visibility(
        visible: _showResults,
        child: ListView.builder(
          itemCount: _searchResults.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_searchResults[index]),
              onTap: () {
                // Handle tapping on a search result
              },
            );
          },
        ),
      ),
    );
  }
}
