import 'package:flutter/material.dart';

class SectionTile extends StatelessWidget {
  final String icon;
  final String title;
  const SectionTile({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(
        color: Colors.blueGrey[400],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 50)),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
