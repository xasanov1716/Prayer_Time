import 'package:flutter_defualt_project/data/models/times_model.dart';

class NamazTimeModel {
  final String region;
  final String date;
  final String weekday;
  final TimesModel timesModel;

  NamazTimeModel(
      {required this.region,
      required this.date,
      required this.weekday,
      required this.timesModel});

  factory NamazTimeModel.fromJson(Map<String, dynamic> json) {
    return NamazTimeModel(
        region: json["region"] as String? ?? "",
        date: json["date"] as String? ?? "",
        weekday: json["weekday"] as String? ?? "",
        timesModel: TimesModel.fromJson(json["times"]) as TimesModel? ??
            TimesModel(
                tongSaharlik: "",
                quyosh: "",
                asr: "",
                peshin: "",
                hufton: "",
                shomIftor: ""));
  }
}
