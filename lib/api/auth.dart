import 'dart:convert' as convert;
import 'dart:io';

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
      final responseJson = convert.jsonDecode(response.body);
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
