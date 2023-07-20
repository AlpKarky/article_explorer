import 'package:flutter/material.dart';

class Article {
  final String title;
  final String snippet;
  final String imageUrl;
  final DateTime publishDate;
  final String fullTextUrl;

  Article({
    required this.title,
    required this.snippet,
    required this.imageUrl,
    required this.publishDate,
    required this.fullTextUrl,
  });

  @override
  bool operator ==(covariant Article other) {
    if (identical(this, other)) return true;
    return other.title == title && other.fullTextUrl == fullTextUrl;
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    final media = json['media'] as List?; // Null check for 'media' key
    final imageUrl =
        media?.isNotEmpty == true ? media![0]['media-metadata'][0]['url'] : '';
    return Article(
      title: json['title'] ?? '',
      snippet: json['abstract'] ?? '',
      imageUrl: imageUrl ?? '', // Default value for imageUrl
      publishDate: DateTime.parse(json['published_date']),
      fullTextUrl: json['url'] ?? '',
    );
  }

  @override
  // TODO: implement hashCode
  int get hashCode => title.hashCode ^ fullTextUrl.hashCode;
}
