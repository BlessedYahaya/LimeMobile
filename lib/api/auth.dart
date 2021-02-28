import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import 'package:lime/api/api.dart';
import 'package:lime/main.dart';
import 'package:lime/models/response/projects.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:lime/models/response.dart';
import 'package:lime/models/store.dart';

Future<TLResponse> login(String email, String password,
    {http.Client client}) async {
  if (client == null) client = IOClient();
  final TLResponse result = TLResponse();
  try {
    final response = await client.post(
      '${appStore.env['API_URL']}/v1/login',
      body: {'email': email, 'password': password},
      headers: {HttpHeaders.acceptHeader: 'application/json'},
    );

    final String contentType = response.headers[HttpHeaders.contentTypeHeader];
    if (contentType != null && contentType.contains('application/json')) {
      result.code = response.statusCode;
      final responseJson = jsonDecode(response.body);
      result.message = responseJson['message'];
      if (response.statusCode == 200) {
        if (responseJson['message'] == 'Login success...') {
          result.data = true;
        } else {
          result.data = false;
        }
      }
    } else {
      result.code = 500;
      result.message = 'An error occurred, please try again later.';
    }
  } catch (error, trace) {
    result.handleError(error, trace);
  }

  return result;
}

class AuthServiceImpl extends AuthService {
  Client client = Client();
  @override
  Future<Map<String, dynamic>> loginUser(Map<String, String> user) async {
    try {
      final res = await client.post(AuthService.ENDPOINT,
          headers: await API.getHeaders(withToken: false),
          body: jsonEncode(user));
      Map<String, dynamic> map = json.decode(
          res.body.length == 0 || res.body == null
              ? new Map().toString()
              : res.body);
      if (res.statusCode == HttpStatus.ok) {
        if (map["token"] is String) {
          await App.setToken(map['token']); // save the user token
          await App.setUname(user['username']); // save username
          map['status'] = "success";
          return (map);
        }
        map['status'] = "error";
        map['message'] = "An unknown error occurred";
        return map;
      } else {
        map['status'] = "error";
        map['message'] = "(${res.statusCode}): ${map['message'] ?? ''}";
        return map;
      }
    } catch (e, t) {
      Map<String, Object> map = handleError(e, t);
      return map;
    }
  }
}

abstract class AuthService with API {
  static const String ENDPOINT = '${API.BASEURL}/login';
  Future<Map<String, dynamic>> loginUser(Map<String, String> loginMap);
}
