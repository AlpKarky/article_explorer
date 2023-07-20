import 'dart:convert';
import 'package:article_explorer/constants/app_constant.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../screens/shared_model/article.dart';
import 'package:http/http.dart' as http;

class ArticleService {
  static const String _period = '7';
  final String _apiKey = dotenv.get('API_KEY');

  Future<List<Article>> fetchArticles() async {
    String url =
        'https://api.nytimes.com/svc/mostpopular/v2/viewed/$_period.json?api-key=$_apiKey';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      //Get list of json in response and convert them to article objects
      final jsonList = json.decode(response.body)['results'] as List;
      List<Article> articles =
          jsonList.map((json) => Article.fromJson(json)).toList();

      //Sort the articles based on published dates
      articles.sort((a, b) => b.publishDate.compareTo(a.publishDate));
      return articles;
    } else {
      throw Exception(
          '${AppConstant.articlesLoadingFail}: (${response.statusCode})');
    }
  }
}
