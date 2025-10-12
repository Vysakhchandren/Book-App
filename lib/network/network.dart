import 'dart:convert';
import 'package:book_reader/models/book.dart';

// import 'package:reader_tracker/models/book.dart';
import 'package:http/http.dart' as http;

class Network {
  //api endpoint
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';
 String key="AIzaSyCSD5wwo9GO0G4_XOPpGbyGY10vyhsMrVY";
  Future<List<Book>> searchBooks(String query) async {
    var url = Uri.parse('$_baseUrl?q=$query&key=$key');
    var response = await http.get(url);
print("***************************");
    if (response.statusCode == 200) {
print(response.body);
      var data = json.decode(response.body);
      if (data['items'] != null && data['items'] is List) {
        List<Book> books = (data['items'] as List<dynamic>)
            .map((book) => Book.fromJson(book as Map<String, dynamic>))
            .toList();
        return books;
        } else {
        return [];
      }
    } else {
      throw Exception('Failed to load books');
    }
  }
}
