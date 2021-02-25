// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MultiChoiceQuestionModel _$MultiChoiceQuestionModelFromJson(Map json) {
  return MultiChoiceQuestionModel(
    id: json['id'] as String,
    surveyID: json['surveyID'] as String,
    question: json['question'] as String,
    message: json['message'] as String,
    isRequired: json['isRequired'] as bool,
    format: json['format'] as String,
  );
}

Map<String, dynamic> _$MultiChoiceQuestionModelToJson(
        MultiChoiceQuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surveyID': instance.surveyID,
      'question': instance.question,
      'message': instance.message,
      'isRequired': instance.isRequired,
      'format': instance.format,
    };

ChecklistQuestionModel _$ChecklistQuestionModelFromJson(Map json) {
  return ChecklistQuestionModel(
    id: json['id'] as String,
    surveyID: json['surveyID'] as String,
    question: json['question'] as String,
    message: json['message'] as String,
    isRequired: json['isRequired'] as bool,
    format: json['format'] as String,
  );
}

Map<String, dynamic> _$ChecklistQuestionModelToJson(
        ChecklistQuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surveyID': instance.surveyID,
      'question': instance.question,
      'message': instance.message,
      'isRequired': instance.isRequired,
      'format': instance.format,
    };

OpenQuestionModel _$OpenQuestionModelFromJson(Map json) {
  return OpenQuestionModel(
    id: json['id'] as String,
    surveyID: json['surveyID'] as String,
    question: json['question'] as String,
    message: json['message'] as String,
    format: json['format'] as String,
    isRequired: json['isRequired'] as bool,
    answer: json['answer'] as String,
  );
}

Map<String, dynamic> _$OpenQuestionModelToJson(OpenQuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surveyID': instance.surveyID,
      'question': instance.question,
      'message': instance.message,
      'isRequired': instance.isRequired,
      'format': instance.format,
      'answer': instance.answer,
    };

RangeQuestionModel _$RangeQuestionModelFromJson(Map json) {
  return RangeQuestionModel(
    id: json['id'] as String,
    surveyID: json['surveyID'] as String,
    question: json['question'] as String,
    message: json['message'] as String,
    format: json['format'] as String,
    range: (json['range'] as List)?.map((e) => e as int)?.toList(),
    label: (json['label'] as List)?.map((e) => e as String)?.toList(),
    isRequired: json['isRequired'] as bool,
    answer: json['answer'] as int ?? 0,
  );
}

Map<String, dynamic> _$RangeQuestionModelToJson(RangeQuestionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'surveyID': instance.surveyID,
      'question': instance.question,
      'message': instance.message,
      'isRequired': instance.isRequired,
      'format': instance.format,
      'answer': instance.answer,
      'range': instance.range,
      'label': instance.label,
    };

OptionModel _$OptionModelFromJson(Map json) {
  return OptionModel(
    id: json['id'] as String,
    label: json['label'] as String,
    selected: json['selected'] as bool,
  )..questionID = json['questionID'] as String;
}

Map<String, dynamic> _$OptionModelToJson(OptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionID': instance.questionID,
      'label': instance.label,
      'selected': instance.selected,
    };

RangeOptionModel _$RangeOptionModelFromJson(Map json) {
  return RangeOptionModel(
    id: json['id'] as String,
    label: (json['label'] as List)?.map((e) => e as String)?.toList(),
    range: (json['range'] as List)?.map((e) => e as int)?.toList(),
    selected: json['selected'] as bool,
  )..questionID = json['questionID'] as String;
}

Map<String, dynamic> _$RangeOptionModelToJson(RangeOptionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionID': instance.questionID,
      'label': instance.label,
      'range': instance.range,
      'selected': instance.selected,
    };
