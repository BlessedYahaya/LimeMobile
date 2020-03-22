// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyModel _$SurveyModelFromJson(Map json) {
  return SurveyModel(
    id: json['id'] as int,
    projectID: json['projectID'] as int,
    label: json['label'] as String,
    description: json['description'] as String,
    dateCreated: json['dateCreated'] as String,
    dateModified: json['dateModified'] as String,
    completionTime: json['completionTime'] as String,
    active: json['active'] as bool,
    responses: json['responses'] as List,
    collectors: (json['collectors'] as List)
        ?.map((e) => e == null ? null : CollectorModel.fromJson(e as Map))
        ?.toList(),
    questions: json['questions'] as List,
    project: json['project'] == null
        ? null
        : ProjectModel.fromJson(json['project'] as Map),
  );
}

Map<String, dynamic> _$SurveyModelToJson(SurveyModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'projectID': instance.projectID,
      'label': instance.label,
      'description': instance.description,
      'dateCreated': instance.dateCreated,
      'dateModified': instance.dateModified,
      'completionTime': instance.completionTime,
      'active': instance.active,
      'responses': instance.responses,
      'questions': instance.questions,
      'collectors': instance.collectors?.map((e) => e?.toJson())?.toList(),
      'project': instance.project?.toJson(),
    };
