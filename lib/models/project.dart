import 'package:json_annotation/json_annotation.dart';
import 'package:lime/models/survey.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class ProjectModel {
  @JsonKey(name: '_id')
  int id;
  String label;
  @JsonKey(name: 'description')
  String description;
  @JsonKey(name: 'createdAt')
  String dateCreated;
  String country;
  List<SurveyModel> surveys;
  bool checked;

  ProjectModel({
    this.id,
    this.label = '',
    this.description = '',
    this.dateCreated = '',
    this.country = '',
    this.checked = false,
    this.surveys = const <SurveyModel>[],
  });

  static final ProjectModel zero = ProjectModel();

  factory ProjectModel.fromJson(Map map) => _$ProjectModelFromJson(map);

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
