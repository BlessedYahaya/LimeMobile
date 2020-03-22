import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

abstract class QuestionModel {
  int id;
  int surveyID;
  String question;
  String message;

  QuestionModel({this.id, this.surveyID, this.question = '', this.message});
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class MultiChoiceQuestionModel extends QuestionModel {
  final List<OptionModel> options;

  MultiChoiceQuestionModel({
    int id,
    int surveyID,
    String question = '',
    String message,
    this.options = const <OptionModel>[],
  }) : super(id: id, surveyID: surveyID, question: question, message: message);

  static final MultiChoiceQuestionModel zero = MultiChoiceQuestionModel();

  factory MultiChoiceQuestionModel.fromJson(Map user) =>
      _$MultiChoiceQuestionModelFromJson(user);

  Map<String, dynamic> toJson() => _$MultiChoiceQuestionModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }

  OptionModel get answer => options
      .firstWhere((OptionModel option) => option.selected, orElse: () => null);

  bool get answered => answer != null;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class OpenQuestionModel extends QuestionModel {
  String answer;

  OpenQuestionModel({
    int id,
    int surveyID,
    String question = '',
    String message,
    this.answer = '',
  }) : super(id: id, surveyID: surveyID, question: question, message: message);

  static final OpenQuestionModel zero = OpenQuestionModel();

  factory OpenQuestionModel.fromJson(Map user) =>
      _$OpenQuestionModelFromJson(user);

  Map<String, dynamic> toJson() => _$OpenQuestionModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class OptionModel {
  int id;
  int questionID;
  String label;
  bool selected;

  OptionModel({this.id, this.label = '', this.selected = false});

  static final OptionModel zero = OptionModel();

  factory OptionModel.fromJson(Map user) => _$OptionModelFromJson(user);

  Map<String, dynamic> toJson() => _$OptionModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}
