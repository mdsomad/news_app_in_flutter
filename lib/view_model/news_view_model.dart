
import 'package:news_app_in_flutter/models/news_channels_headIines_modeI.dart';
import 'package:news_app_in_flutter/repository/news_repository.dart';

class NewsViewModel {


  final _rep = NewsRepository();

  Future<NewsChannelsHeadIinesModeI> fetchNewsChannelHeadlinesApi()async{

    final response = await _rep.fetchNewsChannelHeadlinesApi();
    return response;
    
  }
  
  
}