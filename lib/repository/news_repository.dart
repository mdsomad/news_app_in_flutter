import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:news_app_in_flutter/models/news_channels_headIines_modeI.dart';

class NewsRepository{
  

  Future<NewsChannelsHeadIinesModeI> fetchNewsChannelHeadlinesApi()async{

    String url = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=0c8ec3914c724bdb80d24f80b5ae1e42";
    
    final response = await http.get(Uri.parse(url));
      
      log(response.body);
      
    if(response.statusCode == 200){
        final body = jsonDecode(response.body);
        return NewsChannelsHeadIinesModeI.fromJson(body);
    }

    throw Exception("Error");
    
      
  }
  
  
}