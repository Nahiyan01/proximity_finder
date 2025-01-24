import 'package:flutter/material.dart';
import 'package:proximity_finder/pages/services_pages.dart';
import 'package:proximity_finder/util/section_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = [
      {'title': 'Hospitals', 'icon': '🏥'},
      {'title': 'Schools', 'icon': '🏫'},
      {'title': 'Colleges', 'icon': '🎓'},
      {'title': 'Restaurants', 'icon': '🍴'},
      {'title': 'Parks', 'icon': '🌳'},
      {'title': 'Malls', 'icon': '🛍️'}
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
