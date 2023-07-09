import 'dart:convert';

import 'package:flutter_defualt_project/models/default_model.dart';

import '../../models/universal_response.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<UniversalResponse> getAllData() async {
    Uri uri = Uri.parse("link");
    try {
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        return UniversalResponse(
            data: (jsonDecode(response.body) as List?)?.map((e) =>
                DefaultModel.fromJson(e)).toString() ?? []);
      }
      return UniversalResponse(error: "ERROR");
    }catch (error){
      return UniversalResponse(error: error.toString());
    }
  }
}