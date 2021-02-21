import 'package:json_annotation/json_annotation.dart';

part 'collector.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class CollectorModel {
  int id;
  int surveyID;
  String label;
  String message;
  List responses;

  CollectorModel({
    this.id,
    this.label = '',
    this.message,
    this.responses = const [],
  });

  static final CollectorModel zero = CollectorModel();

  factory CollectorModel.fromJson(Map user) => _$CollectorModelFromJson(user);

  Map<String, dynamic> toJson() => _$CollectorModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}
