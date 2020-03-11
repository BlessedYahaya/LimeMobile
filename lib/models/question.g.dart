// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionModel _$QuestionModelFromJson(Map json) {
  return QuestionModel(
    id: json['id'] as int,
    question: json['question'] as String,
    message: json['message'] as String,
    options: (json['options'] as List)
        ?.map((e) => e == null ? null : OptionModel.fromJson(e as Map))
        ?.toList(),
  )..surveyID = json['surveyID'] as int;
}

Map<String, dynamic> _$QuestionModelToJson(QuestionModel instance) =>
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
    question: json['question'] as String,
    answer: json['answer'] as String,
  )..surveyID = json['surveyID'] as int;
}

Map<String, dynamic> _$OpenQuestionModelToJson(OpenQuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surveyID': instance.surveyID,
      'question': instance.question,
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
