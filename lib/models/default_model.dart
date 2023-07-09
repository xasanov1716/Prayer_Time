import 'package:hive/hive.dart';

part 'default_model.g.dart';


@HiveType(typeId: 1)
class DefaultModel {
  @HiveField(0)
  final num id;
  @HiveField(1)
  final String name;

  DefaultModel({required this.id, required this.name});

  factory DefaultModel.fromJson(Map<String, dynamic> json) {
    return DefaultModel(
        id: json["id"] as num? ?? 0,
        name: json["name"] as String? ?? "");
  }
}
