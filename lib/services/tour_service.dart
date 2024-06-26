import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/tour.dart';

// Service for fetching tours
class TourService {
  final String baseUrl;

  TourService(this.baseUrl);

  Future<List<Tour>> fetchTours() async {
    final response = await http.get(Uri.parse('$baseUrl/tours/tours'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Tour> tours = (jsonData['data']['tours'] as List)
          .map((tourJson) => Tour.fromJson(tourJson))
          .toList();
      return tours;
    } else {
      throw Exception('Failed to fetch tours');
    }
  }
}
