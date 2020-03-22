// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collector.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectorModel _$CollectorModelFromJson(Map json) {
  return CollectorModel(
    id: json['id'] as int,
    label: json['label'] as String,
    message: json['message'] as String,
    responses: json['responses'] as List,
  )..surveyID = json['surveyID'] as int;
}

Map<String, dynamic> _$CollectorModelToJson(CollectorModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surveyID': instance.surveyID,
      'label': instance.label,
      'message': instance.message,
      'responses': instance.responses,
    };
