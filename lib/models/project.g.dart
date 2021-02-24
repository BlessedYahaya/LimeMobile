// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map json) {
  return ProjectModel(
    id: json['id'] as String,
    label: json['label'] as String,
    description: json['description'] as String,
    dateCreated: json['dateCreated'] as String,
    country: json['country'] as String,
    checked: json['checked'] as bool ?? false,
    surveys: (json['survey'] as List)
        ?.map((e) => e == null ? null : SurveyModel.fromJson(e as Map))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'description': instance.description,
      'dateCreated': instance.dateCreated,
      'country': instance.country,
      'survey': instance.surveys?.map((e) => e?.toJson())?.toList(),
      'checked': instance.checked,
    };
