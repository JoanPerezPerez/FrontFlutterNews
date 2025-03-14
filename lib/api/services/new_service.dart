import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/new_model.dart';

class ApiService {
  final String apiUrl = 'http://10.0.2.2:40000/news';

  Future<List<New>> fetchNews() async {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data['result'] != null) {
        final List<dynamic> newsList = data['result'];
        return newsList.map((json) => New.fromJson(json)).take(4).toList();  //limitem a sol agafar les 4 primeres noticies
      } else {
        return [];
      }
    } else {
      throw Exception('Failed to load news');
    }
  }
}
