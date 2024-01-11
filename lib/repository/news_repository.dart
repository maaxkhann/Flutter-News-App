import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/model/news_category_model.dart';
import 'package:news_app/model/news_headlines_model.dart';

class NewsRepository {
  Future<NewsHeadlinesModel> fetchNewsHeadlines(String source) async {
    String url =
        'https://newsapi.org/v2/top-headlines?sources=$source&apiKey=d88ffe9371b643b4af7eb7c705649742';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsHeadlinesModel.fromJson(body);
    }
    throw 'Error';
  }

  Future<NewsCategoryModel> fetchNewsCategory(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=$category&apiKey=d88ffe9371b643b4af7eb7c705649742';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsCategoryModel.fromJson(body);
    }
    throw 'Error';
  }
}
