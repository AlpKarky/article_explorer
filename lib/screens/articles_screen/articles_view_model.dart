import 'package:article_explorer/constants/app_constant.dart';
import 'package:article_explorer/service/article_service.dart';
import 'package:get/get.dart';
import '../shared_model/article.dart';

class ArticlesViewModel extends GetxController {
  final ArticleService _articleService;

  ArticlesViewModel(this._articleService);

  @override
  void onInit() {
    super.onInit();
    fetchArticles();
  }

  final RxList<Article> _articles = <Article>[].obs;
  List<Article> get articles => _articles;

  final RxBool _isLoading = true.obs;
  bool get isLoading => _isLoading.value;

  final RxString _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;

  Future<void> fetchArticles() async {
    try {
      _isLoading.value = true;

      _articles.assignAll(await _articleService.fetchArticles());
      _isLoading.value = false;
    } catch (e) {
      _isLoading.value = false;
      _errorMessage.value = AppConstant.articlesLoadingFail;
      //error details can be monitored with [e]
    }
  }
}
