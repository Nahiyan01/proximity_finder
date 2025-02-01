import 'dart:convert';
import 'package:http/http.dart' as http;

class BarikoiService {
  final String apiKey;

  BarikoiService({required this.apiKey});

  Future<Map<String, dynamic>> getPlaces(String area, String type) async {
    final query = '$area,$type';
    final url =
        'https://barikoi.xyz/api/v2/search-place?q=$query&api_key=$apiKey';

    final response = await http.get(Uri.parse(url));
    print('Request URL: $url'); // Debug print to check request URL

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Response Data: $data'); // Debug print to check response data
      return {
        'places': List<Map<String, dynamic>>.from(data['places'] ?? []),
        'session_id':
            data['session_id'].toString(), // Ensure session_id is a String
      };
    } else {
      print(
          'Failed to load places: ${response.statusCode}'); // Debug print to check status code
      throw Exception('Failed to load places');
    }
  }

  Future<Map<String, dynamic>> getNearbyPlaces(
      double latitude, double longitude, String type, double radius) async {
    final url =
        'https://barikoi.xyz/v2/api/search/nearby/category/$radius/10?api_key=$apiKey&longitude=$longitude&latitude=$latitude&ptype=$type';

    print('Request URL: $url'); // Debug print to check request URL

    final response = await http.get(Uri.parse(url));
    print(
        'Response Status Code: ${response.statusCode}'); // Debug print to check status code

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Response Data: $data'); // Debug print to check response data
      return {
        'places': List<Map<String, dynamic>>.from(data['places'] ?? []),
        'session_id':
            data['session_id'].toString(), // Ensure session_id is a String
      };
    } else {
      print(
          'Failed to load nearby places: ${response.statusCode}'); // Debug print to check status code
      throw Exception('Failed to load nearby places');
    }
  }
}
