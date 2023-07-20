import 'package:article_explorer/constants/app_constant.dart';
import 'package:article_explorer/screens/shared_model/article.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;

class ArticleDetailsViewModel extends GetxController {
  Future<String> _parseBodyText(String fullTextUrl) async {
    //Common tag of texts in the web page.

    Uri url = Uri.parse(fullTextUrl);
    var response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);

    //Parse only the texts from the page using their common tag
    List<String> pageTexts = html
        .querySelectorAll(AppConstant.parseTag)
        .map((e) => e.innerHtml.trim())
        .toList();
    if (pageTexts.isEmpty) {
      pageTexts = html
          .querySelectorAll(AppConstant.parseTagInteractivePages)
          .map((e) => e.innerHtml.trim())
          .toList();
    }

    String fullBodyText = '';
    for (final String text in pageTexts) {
      fullBodyText = '$fullBodyText$text\n\n';
    }
    return fullBodyText;
  }

  String _stripStringFromTags(String htmlString) {
    final document = parser.parse(htmlString);
    final String parsedString =
        parser.parse(document.body?.text).documentElement?.text ?? '';
    return parsedString;
  }

  Future<String> getCleanBodyText(Article article) async {
    String htmlString = await _parseBodyText(article.fullTextUrl);
    String cleanBodyText = _stripStringFromTags(htmlString);
    return cleanBodyText;
  }

  String formatDate(DateTime? date) {
    if (date == null) return '';

    // Format the date as Month.Day.Year
    return DateFormat('MM.dd.yyyy').format(date);
  }
}
