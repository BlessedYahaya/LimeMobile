import 'package:json_annotation/json_annotation.dart';
import 'package:lime/models/survey.dart';
part 'surveys.g.dart';

@JsonSerializable(explicitToJson: true, anyMap: true)
class SurveyResponse {
  String error, message;
  @JsonKey(name: "data")
  List<SurveyModel> surveys;

  SurveyResponse({this.error, this.message, this.surveys});

  factory SurveyResponse.fromJson(Map json) => _$SurveyResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SurveyResponseToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}
