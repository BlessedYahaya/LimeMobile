import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lime/api/auth.dart';
import 'package:lime/api/projects.dart';
import 'package:lime/api/surveys.dart';
import 'package:lime/components/toast.dart';
import 'package:lime/main.dart';
import 'package:lime/models/project.dart';
import 'package:lime/models/question.dart';
import 'package:lime/models/response/projects.dart';
import 'package:lime/models/response/surveys.dart';
import 'package:lime/models/submitSR.dart';
import 'package:lime/models/survey.dart';
import 'package:lime/models/user.dart';
import 'package:lime/views/dashboard.dart';
import 'package:lime/views/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreModel extends ChangeNotifier {
  static final StoreModel _singleton = StoreModel._internal();
  ProjectServiceImpt projectServiceImpt = new ProjectServiceImpt();
  SurveyServiceImpt surveyServiceImpt = new SurveyServiceImpt();
  AuthServiceImpl authServiceImpl = new AuthServiceImpl();
  StoreModel._internal() {
    _darkMode = false;
    _authenticated = false;
    _processing = false;

    user = UserModel.zero;
    env = {};
  }

  StoreModel.zero() {
    StoreModel._internal();
  }

  factory StoreModel() {
    return _singleton;
  }

  bool _darkMode;
  bool _authenticated;
  bool _processing = false;
  bool firstRun;
  String flutterEnv = 'production';
  Map<String, String> env;
  UserModel user;
  Uint8List picture;
  Brightness oldPlatformBrightness;
  Brightness platformBrightness;
  Brightness oldBrightness;
  Brightness brightness;
  // app-wide data stores
  List<ProjectModel> _projects;
  List<SurveyModel> _surveys;

  /// get all user projects
  void getProjects(BuildContext context) async {
    processing = true;
    try {
      ProjectResponse response = await projectServiceImpt.getAllProjects();
      await getSurveys(context);
      if (response.error == 'error') {
        // handle error, show a toast or something
        Toast.show('ERROR ${response.message ?? ''}', context,
            backgroundColor: Colors.red, backgroundRadius: 50);
      } else {
        projects = response.projects;
      }
    } catch (e, t) {
      // handle error
      var error = projectServiceImpt.handleError(e, t);
      Toast.show('ERROR ${error['message'] ?? ''}', context,
          backgroundColor: Colors.red, backgroundRadius: 50);
    }
    processing = false;
  }

  /// get all user surveys
  Future<void> getSurveys(BuildContext context) async {
    processing = true;
    try {
      SurveyResponse response = await surveyServiceImpt.getAllSurveys();
      if (response.error == 'error') {
        // handle error, show a toast or something
        Toast.show('ERROR ${response.message ?? ''}', context,
            backgroundColor: Colors.red, backgroundRadius: 50);
      } else {
        response.surveys.forEach((survey) {
          survey.questions = survey.questions.map((question) {
            if (question['options'] is List<dynamic>) {
              if (question['format'] == 'multichoice') {
                List<OptionModel> options = question['options']
                    .map<OptionModel>((option) =>
                        OptionModel(id: question['id'], label: option))
                    .toList();
                ChecklistQuestionModel questionModel =
                    ChecklistQuestionModel.fromJson(question);
                questionModel.options = options;
                return questionModel;
              } else {
                List<OptionModel> options = question['options']
                    .map<OptionModel>((option) =>
                        OptionModel(id: question['id'], label: option))
                    .toList();
                MultiChoiceQuestionModel questionModel =
                    MultiChoiceQuestionModel.fromJson(question);
                questionModel.options = options;
                return questionModel;
              }
            }
            if (question['options'] is Map) if (question['format'] ==
                'linearscale') {
              RangeQuestionModel questionModel =
                  RangeQuestionModel.fromJson(question);
              questionModel.id = question['id'];
              questionModel.range = question['options']['range'];
              questionModel.label = question['options']['label'];
              print(question);
              return questionModel;
            }
            return OpenQuestionModel.fromJson(question);
          }).toList();
        });
        surveys = response.surveys;
      }
    } catch (e, t) {
      // handle error
      var error = surveyServiceImpt.handleError(e, t);
      Toast.show('ERROR ${error['message'] ?? ''}', context,
          backgroundColor: Colors.red, backgroundRadius: 50);
    }
    processing = false;
  }

  void submitResponse(BuildContext context, SurveyModel survey) async {
    processing = true;
    List<Map<String, dynamic>> responses = [];
    survey.questions.forEach((question) {
      if (question is MultiChoiceQuestionModel) {
        Map<String, dynamic> _response = new Map();
        _response['isRequired'] = question.isRequired;
        _response['responseValue'] = [
          question.answered ? question.answer.label : ''
        ];
        responses.add(_response);
      }
      if (question is OpenQuestionModel) {
        Map<String, dynamic> _response = new Map();
        _response['isRequired'] = question.isRequired;
        _response['responseValue'] = [question.answer];
        responses.add(_response);
      }
      if (question is ChecklistQuestionModel) {
        Map<String, dynamic> _response = new Map();
        _response['isRequired'] = question.isRequired;
        _response['responseValue'] = question.answer.map((res) {
          if (res.selected) {
            return res.label;
          }
        }).toList();
        responses.add(_response);
      }
      if (question is RangeQuestionModel) {
        Map<String, dynamic> _response = new Map();
        _response['isRequired'] = question.isRequired;
        _response['responseValue'] = [question.answer];
        responses.add(_response);
      }
    });
    try {
      SubmitSResponse response = await surveyServiceImpt.submitResponse(
          SubmitSRequest(
              note: survey.note ?? "",
              response: responses,
              surveyID: survey.id));
      if (response.error == 'error') {
        Toast.show('ERROR ${response.message ?? ''}', context,
            backgroundColor: Colors.red, backgroundRadius: 50);
      } else {
        Toast.show('RESPONSE SUCCESSFULLY SENT', context,
            backgroundColor: Colors.green, backgroundRadius: 50);
        Future.delayed(Duration(seconds: 1), () {
          App.pushPageRoute(DashboardView());
        });
      }
    } catch (e, t) {
      var error = surveyServiceImpt.handleError(e, t);
      Toast.show('ERROR ${error['message'] ?? ''}', context,
          backgroundColor: Colors.red, backgroundRadius: 50);
      // handle error
    }
    processing = false;
  }

  bool get isDarkMode => _darkMode == true;

  bool get isAuthenticated => _authenticated;
  List<ProjectModel> get projects => _projects;
  set projects(List<ProjectModel> projects) {
    this._projects = projects;
    notifyListeners();
  }

  List<SurveyModel> get surveys => _surveys;
  set surveys(List<SurveyModel> surveys) {
    this._surveys = surveys;
    notifyListeners();
  }

  bool get isProcessing => _processing;

  set darkMode(bool value) {
    if (_darkMode != value) {
      _darkMode = value;
      _saveThemeMode();
      notifyListeners();
    }
  }

  set processing(bool value) {
    this._processing = value;
    notifyListeners();
  }

  void login(BuildContext context, Map<String, String> loginMap) async {
    processing = true;
    try {
      Map<String, dynamic> response = await authServiceImpl.loginUser(loginMap);
      processing = false;
      if (response['status'] == 'success') {
        App.pushPageRoute(DashboardView());
      } else {
        Toast.show('ERROR ${response['message'] ?? ''}', context,
            backgroundColor: Colors.red, backgroundRadius: 50);
      }
    } catch (e, t) {
      processing = false;
      var error = surveyServiceImpt.handleError(e, t);
      Toast.show('ERROR ${error['message'] ?? ''}', context,
          backgroundColor: Colors.red, backgroundRadius: 50);
      // handle error

    }
  }

  Future<void> logout() async {
    await App.setToken("");
    Future.delayed(Duration(milliseconds: 1000), () {
      App.pushPageRoute(LoginView());
    });
  }

  onChangePlatformBrightness(Brightness _platformBrightness) async {
    bool isDarkPlatform = _platformBrightness == Brightness.dark;
    platformBrightness = _platformBrightness;
    oldBrightness = isDarkMode ? Brightness.dark : Brightness.light;

    if (platformBrightness != oldBrightness) {
      if (isDarkPlatform && !isDarkMode) {
        darkMode = true;
      } else if (!isDarkPlatform && isDarkMode) {
        darkMode = false;
      }
    }
  }

  Future _saveThemeMode() async {
    var sharedPref = await SharedPreferences.getInstance();
    brightness = isDarkMode ? Brightness.dark : Brightness.light;
    oldBrightness = brightness;
    oldPlatformBrightness = platformBrightness;
    return sharedPref.setBool('darkMode', isDarkMode);
  }
}

final StoreModel appStore = StoreModel();
