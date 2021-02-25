// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyModel _$SurveyModelFromJson(Map json) {
  return SurveyModel(
    id: json['id'] as String,
    projectID: json['projectID'] as String,
    label: json['label'] as String,
    description: json['description'] as String,
    dateCreated: json['dateCreated'] as String,
    dateModified: json['dateModified'] as String,
    completionTime: json['completionTime'] as String,
    note: json['note'] as String,
    active: json['active'] as bool ?? false,
    status: json['status'] as String,
    responses: json['responses'] as int,
    collectors: (json['collectors'] as List)
        ?.map((e) => e == null ? null : CollectorModel.fromJson(e as Map))
        ?.toList(),
    questions: json['question'] as List,
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
      'note': instance.note,
      'active': instance.active,
      'status': instance.status,
      'responses': instance.responses,
      'question': instance.questions,
      'collectors': instance.collectors?.map((e) => e?.toJson())?.toList(),
      'project': instance.project?.toJson(),
    };
