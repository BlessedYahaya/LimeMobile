import 'package:json_annotation/json_annotation.dart';
import 'package:lime_mobile_app/models/collector.dart';
import 'package:lime_mobile_app/models/project.dart';
import 'package:lime_mobile_app/models/question.dart';

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
  List responses;
  List<QuestionModel> questions;
  List<CollectorModel> collectors;
  ProjectModel project;

  SurveyModel({
    this.id,
    this.projectID,
    this.label = '',
    this.description = '',
    this.dateCreated = '',
    this.dateModified = '',
    this.completionTime = '',
    this.active = false,
    this.responses = const [],
    this.collectors = const <CollectorModel>[],
    this.questions = const <QuestionModel>[],
    this.project,
  });

  static final SurveyModel zero = SurveyModel();

  factory SurveyModel.fromJson(Map user) => _$SurveyModelFromJson(user);

  Map<String, dynamic> toJson() => _$SurveyModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}
