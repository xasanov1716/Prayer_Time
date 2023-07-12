import 'dart:convert';


import 'package:flutter_defualt_project/data/models/namaz_time_model.dart';
import 'package:http/http.dart' as http;

import '../models/universal_response.dart';

class ApiProvider {
  Future<UniversalResponse> getDailyTime(String region) async {
    Uri uri = Uri.parse("https://islomapi.uz/api/present/day?region=$region");
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return UniversalResponse(
            data: NamazTimeModel.fromJson(jsonDecode(response.body)));
      }else if (response.statusCode != 200) {
        return UniversalResponse(error: 'Error: Status code not equal to 200');
      }
      return UniversalResponse(error: 'Error: Time not found');
    }catch (error){
      return UniversalResponse(error: error.toString());
    }
  }
}