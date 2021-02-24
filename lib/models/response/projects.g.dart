// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectResponse _$ProjectResponseFromJson(Map json) {
  return ProjectResponse(
    error: json['error'] as String,
    message: json['message'] as String,
    projects: (json['data'] as List)
        ?.map((e) => e == null ? null : ProjectModel.fromJson(e as Map))
        ?.toList(),
  );
}

Map<String, dynamic> _$ProjectResponseToJson(ProjectResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.projects?.map((e) => e?.toJson())?.toList(),
    };
