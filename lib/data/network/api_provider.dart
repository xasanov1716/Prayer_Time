import 'dart:convert';


import 'package:http/http.dart' as http;

import '../models/default_model.dart';
import '../models/universal_response.dart';

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