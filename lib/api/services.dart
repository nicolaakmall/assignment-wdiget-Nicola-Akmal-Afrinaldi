import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/merchan_models.dart';

class Api {
  Future<List<MerchantModels>> readMerchant() async {
    // Pura2 get API
    final jsonData = await rootBundle.loadString('assets/json/data.json');
    final decoded = json.decode(jsonData) as List<dynamic>;

    return decoded.map((e) => MerchantModels.fromJson(e)).toList();
  }
}
