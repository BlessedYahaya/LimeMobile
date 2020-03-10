import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class QuestionModel {
  int id;
  int surveyID;
  String question;
  String message;
  List<OptionModel> options;

  QuestionModel({
    this.id,
    this.question = '',
    this.message,
    this.options = const <OptionModel>[],
  });

  static final QuestionModel zero = QuestionModel();

  factory QuestionModel.fromJson(Map user) => _$QuestionModelFromJson(user);

  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }

  OptionModel get answer => options
      .firstWhere((OptionModel option) => option.selected, orElse: () => null);

  bool get answered => answer != null;
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class OpenQuestionModel {
  int id;
  int surveyID;
  String question;
  String answer;

  OpenQuestionModel({this.id, this.question = '', this.answer = ''});

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
