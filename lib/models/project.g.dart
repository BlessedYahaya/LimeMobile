// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map json) {
  return ProjectModel(
    id: json['_id'] as int,
    label: json['label'] as String,
    description: json['description'] as String,
    dateCreated: json['createdAt'] as String,
    country: json['country'] as String,
    checked: json['checked'] as bool,
    surveys: (json['surveys'] as List)
        ?.map((e) => e == null ? null : SurveyModel.fromJson(e as Map))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'label': instance.label,
      'description': instance.description,
      'createdAt': instance.dateCreated,
      'country': instance.country,
      'surveys': instance.surveys?.map((e) => e?.toJson())?.toList(),
      'checked': instance.checked,
    };
