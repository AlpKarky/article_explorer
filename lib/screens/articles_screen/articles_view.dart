import 'package:article_explorer/constants/app_constant.dart';
import 'package:article_explorer/constants/app_padding.dart';
import 'package:article_explorer/screens/articles_screen/articles_view_model.dart';
import 'package:article_explorer/screens/shared_model/article.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../article_details_screen/article_details_view.dart';

class ArticlesView extends StatelessWidget {
  final ArticlesViewModel _articleViewModel = Get.find<ArticlesViewModel>();

  ArticlesView({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double imageWidth = size.width / 8;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstant.appBarTitleMain),
      ),
      body: SafeArea(
        child: Padding(
          padding: AppPadding.pagePaddingAllEdges,
          child: Obx(
            () {
              if (_articleViewModel.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (_articleViewModel.errorMessage.isNotEmpty) {
                return _ErrorText(articleViewModel: _articleViewModel);
              }
              {
                return ListView.builder(
                  itemCount: _articleViewModel.articles.length,
                  itemBuilder: (context, index) {
                    final article = _articleViewModel.articles[index];
                    return _articleViewModel.articles.isNotEmpty
                        ? Padding(
                            padding: AppPadding.paddingLowMedium,
                            child: InkWell(
                              onTap: () => Get.to(
                                ArticleDetailsView(
                                  article: article,
                                ),
                              ),
                              child: _ArticleCard(
                                  article: article,
                                  imageWidth: imageWidth,
                                  maxLinesInCardText:
                                      AppConstant.maxLinesInCardText),
                            ),
                          )
                        : const Center(
                            child: Text(AppConstant.articlesLoadingFail));
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText({
    required ArticlesViewModel articleViewModel,
  }) : _articleViewModel = articleViewModel;

  final ArticlesViewModel _articleViewModel;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(_articleViewModel.errorMessage.isNotEmpty
            ? _articleViewModel.errorMessage
            : AppConstant.articlesLoadingFail));
  }
}

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({
    required this.article,
    required this.imageWidth,
    required this.maxLinesInCardText,
  });

  final Article article;
  final double imageWidth;
  final int maxLinesInCardText;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: AppConstant.allCircularRadiusMedium,
                  child: CachedNetworkImage(
                    width: imageWidth,
                    imageUrl: article.imageUrl,
                    placeholder: (_, __) =>
                        const Center(child: CircularProgressIndicator()),
                    errorWidget: (_, __, ___) =>
                        const Center(child: Icon(Icons.error)),
                  ),
                ),
                title: Text(article.title),
                subtitle: Text(
                  article.snippet,
                  maxLines: maxLinesInCardText,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: SizedBox(
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
