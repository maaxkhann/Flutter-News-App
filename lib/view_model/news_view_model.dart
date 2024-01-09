import 'package:fluttertoast/fluttertoast.dart';
import 'package:news_app/model/news_headlines_model.dart';
import 'package:news_app/repository/news_repository.dart';

class NewsViewModel {
  NewsRepository newsRepository = NewsRepository();

  Future<NewsHeadlinesModel> fetchNewsHeadlines() async {
    try {
      final response = await newsRepository.fetchNewsHeadlines();
      return response;
    } catch (e) {
      Fluttertoast.showToast(msg: 'Something went wrong');
      rethrow;
    }
  }
}
