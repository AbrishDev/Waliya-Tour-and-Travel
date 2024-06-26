import 'dart:convert';
import 'package:http/http.dart' as http;

class BookingService {
  final String baseUrl;

  BookingService(this.baseUrl);

  Future<void> bookTour(String username, String tourName) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/bookings/book'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'tourName': tourName,
      }),
    );

    if (response.statusCode != 200) {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] ?? 'Failed to book tour.';
      throw Exception(errorMessage);
    }
  }
}
