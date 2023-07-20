import 'package:article_explorer/screens/articles_screen/articles_view_model.dart';
import 'package:article_explorer/screens/shared_model/article.dart';
import 'package:flutter/material.dart';
import 'package:article_explorer/constants/app_constant.dart';
import 'package:article_explorer/screens/articles_screen/articles_view.dart';
import 'package:article_explorer/service/article_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mocktail/mocktail.dart';

class MockArticleService extends Mock implements ArticleService {}

void main() {
  late MockArticleService mockArticleService;

  setUp(() {
    mockArticleService = MockArticleService();
    Get.put<ArticlesViewModel>(ArticlesViewModel(mockArticleService));
  });

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

  void arrangeArticleServiceReturnsTwoArticlesAfterTwoSecondDelay() {
    when(() => mockArticleService.fetchArticles()).thenAnswer((_) async {
      await Future.delayed(const Duration(seconds: 2));
      return articlesFromService;
    });
  }

  Widget getWidgetUnderTest() {
    return GetMaterialApp(
      title: AppConstant.appTitle,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(centerTitle: true, toolbarHeight: 80),
        cardTheme: CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(width: 0.5),
            ),
            margin: EdgeInsets.zero),
      ),
      home: ArticlesView(),
      debugShowCheckedModeBanner: false,
    );
  }

  testWidgets('check if title is displayed', (widgetTester) async {
    arrangeArticleServiceReturnsTwoArticles();
    await widgetTester.pumpWidget(getWidgetUnderTest());
    expect(find.text('Articles'), findsOneWidget);
  });

  testWidgets(
    'check if loading indicator is displayed while articles are loading',
    (widgetTester) async {
      arrangeArticleServiceReturnsTwoArticlesAfterTwoSecondDelay();

      await widgetTester.pumpWidget(getWidgetUnderTest());
      await widgetTester.pump(const Duration(milliseconds: 500));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      await widgetTester.pumpAndSettle();
    },
  );
}
