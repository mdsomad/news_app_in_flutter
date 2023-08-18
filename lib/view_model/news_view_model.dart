import 'package:news_app_in_flutter/models/categories_news_modeI.dart';
import 'package:news_app_in_flutter/models/news_channels_headIines_modeI.dart';
import 'package:news_app_in_flutter/repository/news_repository.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelsHeadIinesModeI> fetchNewsChannelHeadlinesApi(
      {required String newsId}) async {
    final response = await _rep.fetchNewsChannelHeadlinesApi(newsId: newsId);
    return response;
  }


  Future<CategoriesNewsModeI> fetchCategoriesNewsApi(
      {required String categories}) async {
    final response = await _rep.fetchCategoriesNewsApi(categories: categories);
    return response;
  }
}
