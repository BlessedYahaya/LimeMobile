import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

enum QuestionFormat { Multichoice, Checkbox, DropDown }

abstract class QuestionModel {
  String id;
  String surveyID;
  String question;
  String message;
  bool isRequired;
  String format;

  QuestionModel(
      {this.id,
      this.surveyID,
      this.question = '',
      this.isRequired = false,
      this.format,
      this.message});
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class MultiChoiceQuestionModel extends QuestionModel {
  @JsonKey(ignore: true)
  List<OptionModel> options;

  MultiChoiceQuestionModel({
    String id,
    String surveyID,
    String question = '',
    String message,
    bool isRequired,
    String format,
    this.options = const <OptionModel>[],
  }) : super(
            id: id,
            surveyID: surveyID,
            question: question,
            message: message,
            isRequired: isRequired,
            format: format);

  static final MultiChoiceQuestionModel zero = MultiChoiceQuestionModel();

  factory MultiChoiceQuestionModel.fromJson(Map map) =>
      _$MultiChoiceQuestionModelFromJson(map);

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
    String id,
    String surveyID,
    String question = '',
    String message,
    String format,
    bool isRequired,
    this.answer = '',
  }) : super(
            id: id,
            surveyID: surveyID,
            question: question,
            message: message,
            isRequired: isRequired,
            format: format);

  static final OpenQuestionModel zero = OpenQuestionModel();

  factory OpenQuestionModel.fromJson(Map map) =>
      _$OpenQuestionModelFromJson(map);

  Map<String, dynamic> toJson() => _$OpenQuestionModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class RangeQuestionModel extends QuestionModel {
  int answer;

  RangeQuestionModel(
      {String id,
      String surveyID,
      String question = '',
      String message,
      String format,
      bool isRequired,
      this.answer = 0})
      : super(
            id: id,
            surveyID: surveyID,
            question: question,
            message: message,
            isRequired: isRequired,
            format: format);

  static final RangeQuestionModel zero = RangeQuestionModel();

  factory RangeQuestionModel.fromJson(Map map) =>
      _$RangeQuestionModelFromJson(map);

  Map<String, dynamic> toJson() => _$RangeQuestionModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class OptionModel {
  String id;
  String questionID;
  String label;
  bool selected;

  OptionModel({this.id, this.label = '', this.selected = false});

  static final OptionModel zero = OptionModel();

  factory OptionModel.fromJson(Map map) => _$OptionModelFromJson(map);

  Map<String, dynamic> toJson() => _$OptionModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}

@JsonSerializable(explicitToJson: true, anyMap: true)
class RangeOptionModel {
  String id;
  String questionID;
  List<String> label;
  List<int> range;
  bool selected;

  RangeOptionModel({this.id, this.label, this.range, this.selected = false});

  static final RangeOptionModel zero = RangeOptionModel();

  factory RangeOptionModel.fromJson(Map map) => _$RangeOptionModelFromJson(map);

  Map<String, dynamic> toJson() => _$RangeOptionModelToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}
