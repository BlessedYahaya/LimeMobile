import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import 'package:lime/api/api.dart';
import 'package:lime/models/response/surveys.dart';

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
}

abstract class SurveyService with API {
  static const String ENDPOINT = '${API.BASEURL}/survey';
  Future<SurveyResponse> getAllSurveys();
}
