import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import 'package:lime/api/api.dart';
import 'package:lime/models/response/surveys.dart';
import 'package:lime/models/submitSR.dart';

class SurveyServiceImpt extends SurveyService {
  Client client = Client();

  @override
  Future<SurveyResponse> getAllSurveys() async {
    try {
      final res = await client.get(SurveyService.ENDPOINT,
          headers: await API.getHeaders());
      Map<String, dynamic> map = json.decode(res.body);
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
      final res = await client.post(
          "${API.BASEURL}/response/${sRequest.surveyID}/",
          headers: await API.getHeaders(),
          body: jsonEncode(sRequest.toJson()));
      Map<String, dynamic> map = json.decode(res.body);
      if (res.statusCode == HttpStatus.ok) {
        return SubmitSResponse.fromJson(map);
      } else {
        map['status'] = "error";
        map['message'] = "An unknown error occured";
        return SubmitSResponse.fromJson(map);
      }
    } catch (e, t) {
      Map<String, Object> map = handleError(e, t);
      return SubmitSResponse.fromJson(map);
    }
  }

  Future<Map<String, dynamic>> getTotalResponse() async {
    try {
      final res = await client.get("${API.BASEURL}/total",
          headers: await API.getHeaders());
      Map<String, dynamic> map = json.decode(res.body);
      if (res.statusCode == HttpStatus.ok) {
        map['status'] = "success";
        return (map);
      } else {
        map['status'] = "error";
        map['message'] = "An unknown error occured";
        return (map);
      }
    } catch (e, t) {
      Map<String, Object> map = handleError(e, t);
      return (map);
    }
  }
}

abstract class SurveyService with API {
  static const String ENDPOINT = '${API.BASEURL}/survey';
  Future<SurveyResponse> getAllSurveys();
  Future<SubmitSResponse> submitResponse(SubmitSRequest sRequest);
}
