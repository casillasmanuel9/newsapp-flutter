
import 'package:flutter/material.dart';
import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final _urlNews = 'http://newsapi.org/v2';
final _apiKey = '6ce4bc6d03364cfb808d26a409e34f1a';

class NewsService with ChangeNotifier {

  List<Article> headlines = [];

  String _selectedCategory = 'business';

  List<Category> categories = [
    Category(icon: FontAwesomeIcons.building, name: 'business' ),
    Category(icon: FontAwesomeIcons.tv, name: 'entertainment' ),
    Category(icon: FontAwesomeIcons.addressCard, name: 'general' ),
    Category(icon: FontAwesomeIcons.headSideVirus, name: 'health' ),
    Category(icon: FontAwesomeIcons.vials, name: 'science' ),
    Category(icon: FontAwesomeIcons.volleyballBall, name: 'sports' ),
    Category(icon: FontAwesomeIcons.memory, name: 'technology' ),
  ];

  Map<String, List<Article>> categoryArticles = {

  };

  NewsService() {
    this.getTopHeadlines();
    this.categories.forEach((item) {
      this.categoryArticles[item.name] = new List();
    });
    this.getArticlesByCategory(this._selectedCategory);
  }

  get selectedCategory => this._selectedCategory;

  set selectedCategory(String valor) {
    this._selectedCategory = valor;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get articulosCategoriaSeleccionada => this.categoryArticles[this._selectedCategory];

  getTopHeadlines() async {
    final url = "$_urlNews/top-headlines?apiKey=$_apiKey&country=mx";
    final respuesta = await http.get(url);
    
    final newsResponse = newsResponseFromJson(respuesta.body);

    this.headlines.addAll(newsResponse.articles);

    notifyListeners();
  }

  getArticlesByCategory(String categoria) async {
    if(this.categoryArticles[categoria].length > 0) return this.categoryArticles[categoria];
    final url = "$_urlNews/top-headlines?apiKey=$_apiKey&country=mx&category=$categoria";
    final respuesta = await http.get(url);
    
    final newsResponse = newsResponseFromJson(respuesta.body);

    this.categoryArticles[categoria].addAll(newsResponse.articles);

    notifyListeners();
  }

}