// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiChoiceQuestionModel _$MultiChoiceQuestionModelFromJson(Map json) {
  return MultiChoiceQuestionModel(
    id: json['id'] as int,
    surveyID: json['surveyID'] as int,
    question: json['question'] as String,
    message: json['message'] as String,
    options: (json['options'] as List)
        ?.map((e) => e == null ? null : OptionModel.fromJson(e as Map))
        ?.toList(),
  );
}

Map<String, dynamic> _$MultiChoiceQuestionModelToJson(
        MultiChoiceQuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surveyID': instance.surveyID,
      'question': instance.question,
      'message': instance.message,
      'options': instance.options?.map((e) => e?.toJson())?.toList(),
    };

OpenQuestionModel _$OpenQuestionModelFromJson(Map json) {
  return OpenQuestionModel(
    id: json['id'] as int,
    surveyID: json['surveyID'] as int,
    question: json['question'] as String,
    message: json['message'] as String,
    answer: json['answer'] as String,
  );
}

Map<String, dynamic> _$OpenQuestionModelToJson(OpenQuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surveyID': instance.surveyID,
      'question': instance.question,
      'message': instance.message,
      'answer': instance.answer,
    };

OptionModel _$OptionModelFromJson(Map json) {
  return OptionModel(
    id: json['id'] as int,
    label: json['label'] as String,
    selected: json['selected'] as bool,
  )..questionID = json['questionID'] as int;
}

Map<String, dynamic> _$OptionModelToJson(OptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionID': instance.questionID,
      'label': instance.label,
      'selected': instance.selected,
    };
