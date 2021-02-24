// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'surveys.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SurveyResponse _$SurveyResponseFromJson(Map json) {
  return SurveyResponse(
    error: json['error'] as String,
    message: json['message'] as String,
    surveys: (json['data'] as List)
        ?.map((e) => e == null ? null : SurveyModel.fromJson(e as Map))
        ?.toList(),
  );
}

Map<String, dynamic> _$SurveyResponseToJson(SurveyResponse instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'data': instance.surveys?.map((e) => e?.toJson())?.toList(),
    };
