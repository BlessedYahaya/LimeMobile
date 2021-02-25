import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import 'package:lime/api/api.dart';
import 'package:lime/models/response/surveys.dart';
import 'package:lime/models/submitSR.dart';

class SurveyServiceImpt extends SurveyService {
  Client client = Client();
  static Future<Map<String, String>> _getHeaders() async {
    var headers = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer ${Strings.app.userToken}',
    };
    return headers;
  }

  @override
  Future<SurveyResponse> getAllSurveys() async {
    try {
      final res = await client.get(SurveyService.ENDPOINT,
          headers: await _getHeaders());
      Map<String, dynamic> map = json.decode(res.body);
      print(map);
      if (res.statusCode == HttpStatus.ok) {
        return SurveyResponse.fromJson(map);
      } else {
        map['status'] = "error";
        return SurveyResponse.fromJson(map);
      }
    } catch (e, t) {
      Map<String, Object> map = handleError(e, t);
      return SurveyResponse.fromJson(map);
    }
  }

  @override
  Future<SubmitSResponse> submitResponse(SubmitSRequest sRequest) async {
    try {
      final res =
          await client.post("${API.BASEURL}/response/${sRequest.surveyID}",
              headers: await _getHeaders(),
              body: json.encode(sRequest.toJson()));
      print(res.body);
      Map<String, dynamic> map = json.decode(res.body);
      print(map);
      if (res.statusCode == HttpStatus.ok) {
        return SubmitSResponse.fromJson(map);
      } else {
        map['status'] = "error";
        return SubmitSResponse.fromJson(map);
      }
    } catch (e, t) {
      Map<String, Object> map = handleError(e, t);
      return SubmitSResponse.fromJson(map);
    }
  }
}

abstract class SurveyService with API {
  static const String ENDPOINT = '${API.BASEURL}/survey';
  Future<SurveyResponse> getAllSurveys();
  Future<SubmitSResponse> submitResponse(SubmitSRequest sRequest);
}
