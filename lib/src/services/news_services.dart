import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news/src/models/category_model.dart';
import 'package:news/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY   = '62fc78119c7a49178ac4ea177f323cbf';

class NewsServices with ChangeNotifier{

  List<Article> headlines = [];
  String _selectedCategory = 'business';

  bool _isLoading = true;

  List<Category> categories = [
    Category(FontAwesomeIcons.building, 'business'),
    Category(FontAwesomeIcons.tv, 'entertainment'),
    Category(FontAwesomeIcons.addressCard, 'general'),
    Category(FontAwesomeIcons.headSideVirus, 'health'),
    Category(FontAwesomeIcons.vials, 'science'),
    Category(FontAwesomeIcons.volleyballBall, 'sports'),
    Category(FontAwesomeIcons.memory, 'technology'),
  ];

  Map<String, List<Article>> categoryArticles = {};
        

  NewsServices(){
    this.getTopHeadlines();
    categories.forEach((item) { 
      this.categoryArticles[item.name] = new List.empty(growable: true);
    });
    this.getArticlesByCategory( this._selectedCategory );
  }

  bool get isLoading => this._isLoading;
  String get selectedCategory => this._selectedCategory;
  
  set selectedCategory(String valor){
    this._selectedCategory = valor;
    this._isLoading = true;
    this.getArticlesByCategory(valor);
    notifyListeners();
  }

  List<Article> get getArticulosCategoriaSeleccionada 
    => this.categoryArticles[this.selectedCategory] ?? [];

  getTopHeadlines() async{

    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=mx';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);
    
    this.headlines.addAll(newsResponse.articles ?? [] );
    notifyListeners();
  }

  getArticlesByCategory(String category) async{

    if(this.categoryArticles[category]!.length > 0){
      this._isLoading = false;
      return this.categoryArticles[category];
    }

    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=mx&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);
    this.categoryArticles[category]?.addAll(newsResponse.articles ?? []);
    this._isLoading = false;
    notifyListeners();
  }

}