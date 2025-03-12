import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/new_model.dart';


class ApiService {
  

  Future<List<New>> fetchNews() async {
    final response = await http.get(Uri.parse('http://localhost:40000/news'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body)['news']; // ojo aqui:
      return data.map((json) => New.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}