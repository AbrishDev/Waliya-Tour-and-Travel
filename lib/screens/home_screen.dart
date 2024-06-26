// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'bookmark_screen.dart';
import 'profile_screen.dart';
import 'detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/tour.dart';
import '../services/tour_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Map<String, String>> _bookmarkedPlaces = [];
  List<Tour> _tours = [];
  final List<Map<String, String>> _filteredPlaces = [];

  final FocusNode _searchFocusNode = FocusNode();
  final TextEditingController _searchController = TextEditingController();

  String _username = ''; // Store username here
  final TourService _tourService =
      TourService('http://localhost:5000/api'); // Replace with your base URL

  @override
  void initState() {
    super.initState();
    _loadUsername(); // Load username when HomeScreen initializes
    _fetchTours(); // Fetch tours when HomeScreen initializes
  }

  void _loadUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'testuser';
    });
  }

  Future<void> _fetchTours() async {
    try {
      List<Tour> tours = await _tourService.fetchTours();
      setState(() {
        _tours = tours;
        _filteredPlaces.clear();
        _filteredPlaces.addAll(tours
            .map((tour) => {
                  'name': tour.name,
                  'location': tour.location,
                  'imageUrl': tour.imageUrl,
                })
            .toList());
      });
    } catch (e) {
      print('Failed to fetch tours: $e');
      showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Failed to fetch tours. Please check your connection.'),
            actions: <Widget>[
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

  List<Widget> get _widgetOptions {
    return [
      _buildPlaceList(),
      const Center(),
      BookmarkScreen(bookmarkedPlaces: _bookmarkedPlaces),
      const ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // Move cursor to the search bar
      _searchFocusNode.requestFocus();
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const ProfileScreen()),
      );
    }
  }

  void _toggleBookmark(String name, String location, String imageUrl) {
    setState(() {
      final place = {'name': name, 'location': location, 'imageUrl': imageUrl};
      bool isBookmarked = _bookmarkedPlaces.any((place) =>
          place['name'] == name &&
          place['location'] == location &&
          place['imageUrl'] == imageUrl);
      if (isBookmarked) {
        _bookmarkedPlaces.removeWhere((place) =>
            place['name'] == name &&
            place['location'] == location &&
            place['imageUrl'] == imageUrl);
      } else {
        _bookmarkedPlaces.add(place);
      }
    });
  }

  Widget _buildPlaceList() {
    return ListView.builder(
      itemCount: _filteredPlaces.length,
      itemBuilder: (context, index) {
        final tour = _tours[index];
        return _buildPlaceCard(
          tour,
        );
      },
    );
  }

  Widget _buildPlaceCard(Tour tour) {
    bool isBookmarked = _bookmarkedPlaces.any((place) =>
        place['name'] == tour.name &&
        place['location'] == tour.location &&
        place['imageUrl'] == tour.imageUrl);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              id: tour.id,
              name: tour.name,
              location: tour.location,
              imageUrl: tour.imageUrl,
              price: tour.price,
              people: tour.people,
              description: tour.description, // Pass description
              username: _username,
              guideName: tour.guideName,
            ),
          ),
        );
      },
      child: Card(
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
                  image:
                      NetworkImage(tour.imageUrl), // Use NetworkImage for URL
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
                        tour.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        tour.location,
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
                  GestureDetector(
                    onTap: () => _toggleBookmark(
                        tour.name, tour.location, tour.imageUrl),
                    child: Icon(
                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterPlaces(String query) {
    _filteredPlaces.clear();
    if (query.isNotEmpty) {
      List<Map<String, String>> filteredList = [];
      for (var tour in _tours) {
        if (tour.name.toLowerCase().contains(query.toLowerCase())) {
          filteredList.add({
            'name': tour.name,
            'location': tour.location,
            'imageUrl': tour.imageUrl,
          });
        }
      }
      setState(() {
        _filteredPlaces.addAll(filteredList);
      });
    } else {
      setState(() {
        _filteredPlaces.addAll(_tours
            .map((tour) => {
                  'name': tour.name,
                  'location': tour.location,
                  'imageUrl': tour.imageUrl,
                })
            .toList());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Waliya Tour & Travel',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Explore the beauty of Ethiopia',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Color.fromARGB(255, 155, 154, 154),
                fontSize: 12.0,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/welcome.jpg'),
              radius: 20.0,
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFE0F4FF),
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.grey),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      focusNode: _searchFocusNode,
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                      ),
                      onChanged: _filterPlaces,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildIconCard(Icons.airplanemode_active),
                  _buildIconCard(Icons.hotel),
                  _buildIconCard(Icons.restaurant),
                  _buildIconCard(Icons.directions_car),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTextColumn('All'),
                _buildTextColumn('Historical'),
                _buildTextColumn('Cultural'),
                _buildTextColumn('Spiritual'),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Center(
                child: _widgetOptions.elementAt(_selectedIndex),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              spreadRadius: 2,
              offset: Offset(0, -1),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.white,
          selectedItemColor: Colors.blue,
          unselectedItemColor: const Color(0xFFB4B4B8),
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Bookmark',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIconCard(IconData iconData) {
    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 2,
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Icon(
            iconData,
            color: Colors.blue,
            size: 32,
          ),
        ),
      ),
    );
  }

  Widget _buildTextColumn(String text) {
    return Column(
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: 24,
          height: 2,
          color: Colors.transparent,
        ),
      ],
    );
  }
}
