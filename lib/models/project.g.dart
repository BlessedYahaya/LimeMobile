// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectModel _$ProjectModelFromJson(Map json) {
  return ProjectModel(
    id: json['id'] as int,
    label: json['label'] as String,
    description: json['description'] as String,
    dateCreated: json['dateCreated'] as String,
  );
}

Map<String, dynamic> _$ProjectModelToJson(ProjectModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'label': instance.label,
      'description': instance.description,
      'dateCreated': instance.dateCreated,
    };
