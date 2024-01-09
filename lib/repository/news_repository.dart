import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_headlines_model.dart';

class NewsRepository {
  Future<NewsHeadlinesModel> fetchNewsHeadlines() async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=d88ffe9371b643b4af7eb7c705649742';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsHeadlinesModel.fromJson(body);
    }
    throw 'Error';
  }
}
