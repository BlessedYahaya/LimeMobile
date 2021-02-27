import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' show Client;
import 'package:lime/api/api.dart';
import 'package:lime/models/response/projects.dart';

class ProjectServiceImpt extends ProjectService {
  Client client = Client();

  @override
  Future<ProjectResponse> getAllProjects() async {
    try {
      final res = await client.get(ProjectService.ENDPOINT,
          headers: await API.getHeaders());
      Map<String, dynamic> map = json.decode(res.body);
      if (res.statusCode == HttpStatus.ok) {
        return ProjectResponse.fromJson(map);
      } else {
        map['status'] = "error";
        return ProjectResponse.fromJson(map);
      }
    } catch (e, t) {
      Map<String, Object> map = handleError(e, t);
      return ProjectResponse.fromJson(map);
    }
  }
}

abstract class ProjectService with API {
  static const String ENDPOINT = '${API.BASEURL}/project';
  Future<ProjectResponse> getAllProjects();
}
