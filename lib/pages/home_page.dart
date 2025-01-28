import 'package:flutter/material.dart';
import 'package:proximity_finder/pages/services_pages.dart';
import 'package:proximity_finder/util/section_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'Hospital', 'icon': '🏥'},
      {'title': 'School', 'icon': '🏫'},
      {'title': 'College', 'icon': '🎓'},
      {'title': 'Restaurant', 'icon': '🍴'},
      {'title': 'Park', 'icon': '🌳'},
      {'title': 'Mall', 'icon': '🛍️'},
      {'title': 'Pharmacy', 'icon': '💊'},
      {'title': 'Supermarket', 'icon': '🛒'},
      {'title': 'Bank', 'icon': '🏦'},
      {'title': 'ATM', 'icon': '🏧'},
      {'title': 'Gas Station', 'icon': '⛽'},
      {'title': 'Police Station', 'icon': '🚓'},
      {'title': 'Fire Station', 'icon': '🚒'},
      {'title': 'Library', 'icon': '📚'},
      {'title': 'Gym', 'icon': '🏋️‍♂️'},
      {'title': 'Cinema', 'icon': '🎬'},
      {'title': 'Hotel', 'icon': '🏨'},
      {'title': 'Bus Station', 'icon': '🚏'},
      {'title': 'Train Station', 'icon': '🚉'},
      {'title': 'Airport', 'icon': '✈️'},
      {'title': 'Post Office', 'icon': '📮'},
      {'title': 'Clinic', 'icon': '🏥'},
      {'title': 'Dentist', 'icon': '🦷'},
      {'title': 'Veterinary', 'icon': '🐾'},
      {'title': 'Church', 'icon': '⛪'},
      {'title': 'Mosque', 'icon': '🕌'},
      {'title': 'Temple', 'icon': '🛕'},
      {'title': 'Museum', 'icon': '🏛️'},
      {'title': 'Zoo', 'icon': '🦁'},
      {'title': 'Beach', 'icon': '🏖️'}
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      drawer: Drawer(
        backgroundColor: Colors.blueGrey[100],
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blueGrey,
              ),
              child: const Text(
                'Proximity Finder',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('Get help from AI'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('login'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('issue a new service'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[400],
        title: Center(child: Text('proximity finder')),
      ),
      body: Column(
        children: [
          Center(
            child: Text("What do you want to search for?",
                style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ServicesPage(category: category['title']!),
                      ),
                    );
                  },
                  child: SectionTile(
                    icon: category['icon']!,
                    title: category['title']!,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
