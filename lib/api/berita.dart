import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/berita_models.dart';

Future<List<Berita>> loadBerita() async {
  final String response =
      await rootBundle.loadString('assets/json/data_berita.json');
  final data = await json.decode(response) as List;
  return data.map((item) => Berita.fromJson(item)).toList();
}


