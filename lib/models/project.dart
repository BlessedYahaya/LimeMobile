import 'package:json_annotation/json_annotation.dart';
import 'package:lime_mobile_app/models/survey.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class ProjectModel {
  int id;
  String label;
  String description;
  String dateCreated;
  String country;
  List<SurveyModel> surveys;

  ProjectModel({
    this.id,
    this.label = '',
    this.description = '',
    this.dateCreated = '',
    this.country = '',
    this.surveys = const <SurveyModel>[],
  });

  static final ProjectModel zero = ProjectModel();

  factory ProjectModel.fromJson(Map user) => _$ProjectModelFromJson(user);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }

  List<SurveyModel> get activeSurveys =>
      surveys.where((SurveyModel s) => s.active).toList(growable: false);
  List<SurveyModel> get draftSurveys =>
      surveys.where((SurveyModel s) => !s.active).toList(growable: false);
}
