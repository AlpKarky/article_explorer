import 'package:article_explorer/screens/articles_screen/articles_view_model.dart';
import 'package:article_explorer/screens/shared_model/article.dart';
import 'package:article_explorer/service/article_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockArticleService extends Mock implements ArticleService {}

void main() {
  late ArticlesViewModel sut;
  late MockArticleService mockArticleService;

  setUp(() {
    mockArticleService = MockArticleService();
    sut = ArticlesViewModel(mockArticleService);
  });

  test('check if initial values are correct', () {
    expect(sut.articles, []);
    expect(sut.isLoading, true);
    expect(sut.errorMessage, '');
  });

  group('fetchArticles', () {
    final List<Article> articlesFromService = [
      Article(
          title: 'Test Article 1',
          snippet: 'Test Snippet 1',
          imageUrl: 'Test Image 1',
          publishDate: DateTime.now(),
          fullTextUrl: 'Test url 1'),
      Article(
          title: 'Test Article 2',
          snippet: 'Test Snippet 2',
          imageUrl: 'Test Image 2',
          publishDate: DateTime.now(),
          fullTextUrl: 'Test url 2')
    ];
    void arrangeArticleServiceReturnsTwoArticles() {
      when(() => mockArticleService.fetchArticles())
          .thenAnswer((_) async => articlesFromService);
    }

    test('check if articles are fetched by ArticleService', () async {
      arrangeArticleServiceReturnsTwoArticles();
      await sut.fetchArticles();
      verify(() => mockArticleService.fetchArticles()).called(1);
    });

    test(
        'check if loading of data is indicated, articles from the service get set, data not being loaded anymore is indicated',
        () async {
      arrangeArticleServiceReturnsTwoArticles();
      final future = sut.fetchArticles();
      expect(sut.isLoading, true);
      await future;
      expect(sut.articles, articlesFromService);
      expect(sut.isLoading, false);
    });
  });
}
