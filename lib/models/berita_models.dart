
import 'dart:convert';
import 'package:flutter/services.dart';

class Berita {
  final String author;
  final String title;
  final String description;
  final String urlToImage;
  final String publishedAt;
  final String content;

  Berita({
    required this.author,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  factory Berita.fromJson(Map<String, dynamic> json) {
    return Berita(
      author: json['author'] ?? 'Unknown',
      title: json['title'],
      description: json['description'],
      urlToImage: json['urlToImage'],
      publishedAt: json['publishedAt'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'title': title,
      'description': description,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt,
      'content': content,
    };
  }
}

Future<List<Berita>> loadBerita() async {
  final String response =
      await rootBundle.loadString('assets/json/data_berita.json');
  final data = await json.decode(response) as List;
  return data.map((item) => Berita.fromJson(item)).toList();
}
