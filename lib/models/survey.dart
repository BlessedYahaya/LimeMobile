import 'package:json_annotation/json_annotation.dart';
import 'package:lime/models/collector.dart';
import 'package:lime/models/project.dart';

part 'survey.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
 class SurveyModel {
  String id;
  String projectID;
  String label;
  String description;
  String dateCreated;
  String dateModified;
  String completionTime;
  String note;
  @JsonKey(defaultValue: false)
  bool active;
  String status;
  int responses;
  @JsonKey(name:'question')
  List questions;
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
    this.note = '',
    this.active = false,
    this.status,
    this.responses = 0,
    this.collectors = const <CollectorModel>[],
    this.questions = const [],
    this.project,
  });

  static final SurveyModel zero = SurveyModel();

  factory SurveyModel.fromJson(Map user) => _$SurveyModelFromJson(user);

  Map<String, dynamic> toJson() => _$SurveyModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }

  bool get hasNote => note != null && note.isNotEmpty;
}
