import 'package:flutter/material.dart';
import 'package:tour_and_travel_app/screens/home_screen.dart';
import 'welcome_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        automaticallyImplyLeading: false, // Remove the back button
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: Icon(
              Icons.settings,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/welcome.jpg'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Abebe K.',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'kebedeabebe@gmail.com',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                _buildProfileOption(
                  icon: Icons.history,
                  text: 'Booking History',
                  onTap: () {
                    // Show booking history dialog
                    _showBookingHistoryDialog(context);
                  },
                ),
                _buildProfileOption(
                  icon: Icons.payment,
                  text: 'Payment Methods',
                  onTap: () {
                    // Show payment methods dialog
                    _showPaymentMethodsDialog(context);
                  },
                ),
                _buildProfileOption(
                  icon: Icons.logout,
                  text: 'Logout',
                  onTap: () {
                    // Handle Logout tap
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WelcomeScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, // Adjust as needed based on the selected screen
        onTap: (index) {
          // Navigate to different screens based on index
          switch (index) {
            case 0:
              // Navigate to ProfileScreen
              break;
            case 1:
              // Navigate to another screen (example: HomeScreen)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
              break;
            // Add more cases as needed for other screens
          }
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          // Add more items for additional screens
        ],
      ),
    );
  }

  Widget _buildProfileOption({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(text),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  void _showBookingHistoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Booking History'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Trip to Paris'),
                subtitle: Text('Date: 2024-01-15'),
              ),
              ListTile(
                title: Text('Trip to New York'),
                subtitle: Text('Date: 2023-12-20'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showPaymentMethodsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Methods'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.credit_card),
                title: Text('Visa **** 1234'),
              ),
              ListTile(
                leading: Icon(Icons.credit_card),
                title: Text('MasterCard **** 5678'),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
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
