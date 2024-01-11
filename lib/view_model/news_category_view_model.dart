import 'package:flutter/material.dart';
import 'package:news_app/model/news_category_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsCategoryViewModel with ChangeNotifier {
  NewsRepository newsRepository = NewsRepository();
  List<String> categoryList = [
    'General',
    'Entertainment',
    'Sports',
    'Health',
    'Buisness',
    'Technology'
  ];
  String? currentCategorySelected;

  void setCategory(String currentCategorySelected) {
    this.currentCategorySelected = currentCategorySelected;
    notifyListeners();
  }

  Future<NewsCategoryModel> fetchNewsCategory(String category) async {
    try {
      final response = await newsRepository.fetchNewsCategory(category);
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
