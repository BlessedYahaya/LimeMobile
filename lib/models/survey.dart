import 'package:json_annotation/json_annotation.dart';

part 'survey.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class SurveyModel {
  int id;
  int projectID;
  String label;
  String description;
  String dateCreated;
  String dateModified;
  String completionTime;
  bool active;
  List response;
  List questions;

  SurveyModel({
    this.id,
    this.projectID,
    this.label = '',
    this.description = '',
    this.dateCreated = '',
    this.dateModified = '',
    this.completionTime = '',
    this.active = false,
    this.response = const [],
    this.questions = const [],
  });

  static final SurveyModel zero = SurveyModel();

  factory SurveyModel.fromJson(Map user) => _$SurveyModelFromJson(user);

  Map<String, dynamic> toJson() => _$SurveyModelToJson(this);
}
