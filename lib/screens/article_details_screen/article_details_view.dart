import 'package:article_explorer/constants/app_constant.dart';
import 'package:article_explorer/constants/app_padding.dart';
import 'package:article_explorer/screens/article_details_screen/article_details_view_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../shared_model/article.dart';

class ArticleDetailsView extends StatefulWidget {
  final Article article;
  final String? fullText;

  const ArticleDetailsView({super.key, required this.article, this.fullText});

  @override
  State<ArticleDetailsView> createState() => _ArticleDetailsViewState();
}

class _ArticleDetailsViewState extends State<ArticleDetailsView> {
  late Future<String> _futureBodyText;
  late ArticleDetailsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = Get.put(ArticleDetailsViewModel());
    _futureBodyText = _viewModel.getCleanBodyText(widget.article);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double imageHeight = size.height / 5;

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstant.appBarTitleDetails),
      ),
      body: Padding(
        padding: AppPadding.pagePaddingAllEdges,
        child: SizedBox(
          height: size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TopImage(imageHeight: imageHeight, widget: widget),
              AppConstant.verticalSpaceLow,
              _TitleText(widget: widget),
              AppConstant.verticalSpaceLow,
              _DateText(viewModel: _viewModel, widget: widget),
              AppConstant.verticalSpaceLow,
              _BodyText(futureBodyText: _futureBodyText),
            ],
          ),
        ),
      ),
    );
  }
}

class _TopImage extends StatelessWidget {
  const _TopImage({
    required this.imageHeight,
    required this.widget,
  });

  final double imageHeight;
  final ArticleDetailsView widget;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: AppConstant.allCircularRadiusHigh,
        child: CachedNetworkImage(
          height: imageHeight,
          fit: BoxFit.cover,
          imageUrl: widget.article.imageUrl,
          placeholder: (context, url) =>
              const Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
        ),
      ),
    );
  }
}

class _TitleText extends StatelessWidget {
  const _TitleText({
    required this.widget,
  });

  final ArticleDetailsView widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.article.title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }
}

class _DateText extends StatelessWidget {
  const _DateText({
    required this.viewModel,
    required this.widget,
  });

  final ArticleDetailsViewModel viewModel;
  final ArticleDetailsView widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      viewModel.formatDate(widget.article.publishDate),
      style: Theme.of(context).textTheme.titleSmall,
    );
  }
}

class _BodyText extends StatelessWidget {
  const _BodyText({
    required this.futureBodyText,
  });

  final Future<String> futureBodyText;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: futureBodyText,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Expanded(
                child: Center(child: CircularProgressIndicator()),
              );
            case ConnectionState.done:
            default:
              if (snapshot.hasData) {
                String bodyText = snapshot.data ?? '';
                return Expanded(
                  child: RawScrollbar(
                    thumbColor: Theme.of(context).colorScheme.onSurface,
                    thickness: AppConstant.scrollBarWidth,
                    radius: AppConstant.circularRadiusMedium,
                    child: SingleChildScrollView(
                      child: Text(
                        bodyText,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Expanded(
                    child: Center(child: Text(snapshot.error.toString())));
              } else {
                return const Expanded(
                    child: Center(child: Text(AppConstant.articleLoadingFail)));
              }
          }
        });
  }
}
