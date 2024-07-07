import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/feedModel.dart';

class ApiService {
  final String baseUrl = "https://api.example.com";

  Future<List<FeedModel>> fetchFeeds() async {
    final response = await http.get(Uri.parse('$baseUrl/feeds'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((feed) => FeedModel.fromJson(feed)).toList();
    } else {
      throw Exception('Failed to load feeds');
    }
  }
}
