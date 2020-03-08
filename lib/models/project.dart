import 'package:json_annotation/json_annotation.dart';

part 'project.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class ProjectModel {
  int id;
  String label;
  String description;
  String dateCreated;

  ProjectModel({
    this.id,
    this.label = '',
    this.description = '',
    this.dateCreated = '',
  });

  static final ProjectModel zero = ProjectModel();

  factory ProjectModel.fromJson(Map user) => _$ProjectModelFromJson(user);

  Map<String, dynamic> toJson() => _$ProjectModelToJson(this);
}
