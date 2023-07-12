import 'package:flutter_defualt_project/data/models/namaz_time_model.dart';
import 'package:flutter_defualt_project/data/network/api_provider.dart';

import '../models/universal_response.dart';

class ApiRepository{
  final ApiProvider apiProvider;
  ApiRepository({required this.apiProvider});

  Future<NamazTimeModel?> getDailyTime({required String region})async{
    UniversalResponse universalResponse=await apiProvider.getDailyTime(region);
    if(universalResponse.error.isEmpty){
      return universalResponse.data as NamazTimeModel;
    }
    return null;
  }
}