import 'dart:convert';


import 'package:flutter_defualt_project/data/models/namaz_time_model.dart';
import 'package:http/http.dart' as http;

import '../models/universal_response.dart';

class ApiProvider {

  Future<UniversalResponse> getMonthlyTime(String month,String region) async {
    Uri uri = Uri.parse("https://islomapi.uz/api/monthly?region=$region&month=$month");
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return UniversalResponse(
            data: (jsonDecode(response.body) as List?)
                ?.map((e) => NamazTimeModel.fromJson(e))
                .toList() ??
                []);
      }
      return UniversalResponse(error: "ERROR");
    } catch (error) {
      return UniversalResponse(error: error.toString());
    }
  }


}