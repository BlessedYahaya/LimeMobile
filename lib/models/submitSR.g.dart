// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submitSR.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubmitSRequest _$SubmitSRequestFromJson(Map json) {
  return SubmitSRequest(
    note: json['note'] as String,
    responses: (json['responses'] as List)
        ?.map((e) => (e as Map)?.map(
              (k, e) => MapEntry(k as String, e),
            ))
        ?.toList(),
  );
}

Map<String, dynamic> _$SubmitSRequestToJson(SubmitSRequest instance) =>
    <String, dynamic>{
      'note': instance.note,
      'responses': instance.responses,
    };

SubmitSResponse _$SubmitSResponseFromJson(Map json) {
  return SubmitSResponse(
    message: json['message'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$SubmitSResponseToJson(SubmitSResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'status': instance.status,
    };
