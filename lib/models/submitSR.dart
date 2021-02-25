import 'package:json_annotation/json_annotation.dart';

part 'submitSR.g.dart';

// submit request model
@JsonSerializable(explicitToJson: true, anyMap: true)
class SubmitSRequest {
  String note;
  @JsonKey(ignore: true)
  String surveyID;
  List<Map<String, dynamic>> response;

  SubmitSRequest({this.note, this.response, this.surveyID});
  factory SubmitSRequest.fromJson(Map map) => _$SubmitSRequestFromJson(map);

  Map<String, dynamic> toJson() => _$SubmitSRequestToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}

// submit response model
@JsonSerializable(explicitToJson: true, anyMap: true)
class SubmitSResponse {
  String message, status, error;

  SubmitSResponse({this.message, this.status});
  factory SubmitSResponse.fromJson(Map map) => _$SubmitSResponseFromJson(map);

  Map<String, dynamic> toJson() => _$SubmitSResponseToJson(this);

  @override
  String toString() {
    return '${toJson()}';
  }
}
