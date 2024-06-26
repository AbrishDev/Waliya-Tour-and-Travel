import 'package:flutter/material.dart';

class BookmarkScreen extends StatelessWidget {
  final List<Map<String, String>> bookmarkedPlaces;

  const BookmarkScreen({super.key, required this.bookmarkedPlaces});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: bookmarkedPlaces.length,
        itemBuilder: (context, index) {
          final place = bookmarkedPlaces[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(place['imageUrl']!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  height: 150,
                ),
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            place['name']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            place['location']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                          const Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow, size: 16),
                              Icon(Icons.star, color: Colors.yellow, size: 16),
                              Icon(Icons.star, color: Colors.yellow, size: 16),
                              Icon(Icons.star, color: Colors.yellow, size: 16),
                              Icon(Icons.star_border,
                                  color: Colors.yellow, size: 16),
                            ],
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.bookmark,
                        color: Colors.white,
                        size: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
