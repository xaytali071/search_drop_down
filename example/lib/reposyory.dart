// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class Repository{
//   List<dynamic> _results = [];
//   bool _isLoading = false;
//
//   Future<void> _search(String query) async {
//     setState(() {
//       _isLoading = true;
//     });
//
//     final url = Uri.parse('https://api.duckduckgo.com/?q=$query&format=json');
//     final response = await http.get(url);
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       setState(() {
//         _results = data["RelatedTopics"];
//         _isLoading = false;
//       });
//     } else {
//       setState(() {
//         _isLoading = false;
//       });
//       throw Exception('Qidiruv amalga oshmadi');
//     }
//   }
// }