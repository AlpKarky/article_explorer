import 'package:article_explorer/constants/app_constant.dart';
import 'package:article_explorer/service/article_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'screens/articles_screen/articles_view.dart';
import 'screens/articles_screen/articles_view_model.dart';

Future<void> main() async {
  await dotenv.load();
  ArticleBinding().dependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
}

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ArticlesViewModel>(() => ArticlesViewModel(ArticleService()));
  }
}
