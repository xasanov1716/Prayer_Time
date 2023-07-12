import 'package:flutter_defualt_project/data/models/times_model.dart';

class NamazTimeModel {
  final String region;
  final int month;
  final int day;
  final String weekday;
  final TimesModel timesModel;

  NamazTimeModel(
      {required this.region,
      required this.month,
      required this.day,
      required this.weekday,
      required this.timesModel});

  factory NamazTimeModel.fromJson(Map<String, dynamic> json) {
    return NamazTimeModel(
        region: json["region"] as String? ?? "",
        day: json["day"] as int? ?? 0,
        month: json["month"] as int? ?? 0,
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
