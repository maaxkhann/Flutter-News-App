import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:news_app/model/news_headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel with ChangeNotifier {
  NewsRepository newsRepository = NewsRepository();
  DateFormat dateFormat = DateFormat('MM dd yyyy');
  FilterList? selectedMenu;
  String source = 'bbc-news';

  void selectMenu(FilterList item, String source) {
    selectedMenu = item;
    this.source = source;
    notifyListeners();
  }

  Future<NewsHeadlinesModel> fetchNewsHeadlines(String source) async {
    try {
      final response = await newsRepository.fetchNewsHeadlines(source);
      return response;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went wrong');
      rethrow;
    }
  }
}

enum FilterList {
  bbcNews,
  bbcSport,
  alJazeeraNews,
  cnnNews,
  espnNews,
}
