import 'dart:convert';
import 'package:http/http.dart' as http;

class BarikoiService {
  final String apiKey;

  BarikoiService({required this.apiKey});

  Future<List<Map<String, dynamic>>> getPlaces(String query) async {
    final url =
        'https://barikoi.xyz/api/v2/search-place?q=$query&api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    print('Request URL: $url'); // Debug print to check request URL

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Response Data: $data'); // Debug print to check response data
      return List<Map<String, dynamic>>.from(data['places'] ?? []);
    } else {
      print(
          'Failed to load places: ${response.statusCode}'); // Debug print to check status code
      throw Exception('Failed to load places');
    }
  }
}
