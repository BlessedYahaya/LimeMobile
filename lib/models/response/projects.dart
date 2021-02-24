import 'package:lime/models/project.dart';
import 'package:json_annotation/json_annotation.dart';
part 'projects.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class ProjectResponse {
  String error, message;
  @JsonKey(name: "data")
  List<ProjectModel> projects;

  ProjectResponse({this.error, this.message, this.projects});

  factory ProjectResponse.fromJson(Map json) => _$ProjectResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ProjectResponseToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}
