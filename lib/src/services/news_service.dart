
import 'package:flutter/material.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _urlNews = 'http://newsapi.org/v2';
final _apiKey = '6ce4bc6d03364cfb808d26a409e34f1a';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];

  NewsService() {
    this.getTopHeadlines();
  }

  getTopHeadlines() async {
    final url = "$_urlNews/top-headlines?apiKey=$_apiKey&country=mx";
    final respuesta = await http.get(url);
    
    final newsResponse = newsResponseFromJson(respuesta.body);

    this.headlines.addAll(newsResponse.articles);

    notifyListeners();
  }

}