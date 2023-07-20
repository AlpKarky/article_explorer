import 'package:flutter/cupertino.dart';

class AppConstant {
  AppConstant._();

  //app string
  static const String appBarTitleMain = 'Articles';
  static const String appBarTitleDetails = 'Article Details';
  static const String appTitle = 'Article Explorer';

  //error string
  static const String articlesLoadingFail =
      'Failed to fetch articles. Please check your internet connection.';

  static const String articleLoadingFail =
      'Failed to fetch the article. Please check your internet connection.';

  //service string
  static const String parseTag = '#story > section > div > div > p';
  static const String parseTagInteractivePages = 'div > p';

  //integer
  static const int maxLinesInCardText = 4;

  //double
  static const double scrollBarWidth = 8;

  //space
  static const SizedBox verticalSpaceLow = SizedBox(
    height: 16,
  );

  //radius
  static const Radius circularRadiusMedium = Radius.circular(10);

  //border radius
  static const BorderRadius allCircularRadiusHigh = BorderRadius.all(
    Radius.circular(20.0),
  );
  static const BorderRadius allCircularRadiusMedium = BorderRadius.all(
    Radius.circular(10.0),
  );
}
