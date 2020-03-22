import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lime_mobile_app/models/collector.dart';
import 'package:lime_mobile_app/models/project.dart';
import 'package:lime_mobile_app/models/question.dart';
import 'package:lime_mobile_app/models/survey.dart';
import 'package:lime_mobile_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreModel extends ChangeNotifier {
  static final StoreModel _singleton = StoreModel._internal();

  StoreModel._internal() {
    _darkMode = false;
    _authenticated = false;
    _processing = false;

    // TODO use UserModel.zero to clear these values
    user = UserModel(
      id: 0,
      firstName: 'John',
      lastName: 'Doe',
    );
    env = {};
    // TODO: remove static data, just assign to empty array []
    projects = [
      ProjectModel(
          label: 'Operations VC',
          country: 'Nigeria',
          dateCreated: '10th of January 2020',
          description:
              'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
          surveys: [
            SurveyModel(
              label: 'Market research product testing',
              active: true,
              dateModified: '12/01/2020',
              responses: [1, 2, 3],
              project: ProjectModel(
                label: 'Operations VC',
                country: 'Nigeria',
                dateCreated: '10th of January 2020',
                description:
                    'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
              ),
            ),
            SurveyModel(
              label: 'Customer satisfaction template',
              dateModified: '12/01/2020',
              project: ProjectModel(
                label: 'Operations VC',
                country: 'Nigeria',
                dateCreated: '10th of January 2020',
                description:
                    'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
              ),
            ),
          ]),
      ProjectModel(
          label: 'LAPL - Project SVG',
          country: 'Nigeria',
          dateCreated: '10th of January 2020',
          description:
              'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
          surveys: [
            SurveyModel(
              label: 'Market research product testing',
              active: true,
              dateModified: '12/01/2020',
              responses: [1, 2, 3],
              project: ProjectModel(
                label: 'Operations VC',
                country: 'Nigeria',
                dateCreated: '10th of January 2020',
                description:
                    'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
              ),
            ),
            SurveyModel(
              label: 'Customer satisfaction template',
              dateModified: '12/01/2020',
              project: ProjectModel(
                label: 'Operations VC',
                country: 'Nigeria',
                dateCreated: '10th of January 2020',
                description:
                    'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
              ),
            ),
            SurveyModel(
              label: 'Customer feedback',
              active: true,
              dateModified: '12/01/2020',
              responses: [1, 2, 3, 4],
              project: ProjectModel(
                label: 'Operations VC',
                country: 'Nigeria',
                dateCreated: '10th of January 2020',
                description:
                    'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
              ),
            ),
          ]),
      ProjectModel(
        label: 'SAPS Project',
        country: 'Nigeria',
        dateCreated: '10th of January 2020',
        description:
            'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
        surveys: [
          SurveyModel(
            label: 'Market research product testing',
            active: true,
            dateModified: '12/01/2020',
            responses: [1, 2, 3],
            project: ProjectModel(
              label: 'Operations VC',
              country: 'Nigeria',
              dateCreated: '10th of January 2020',
              description:
                  'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
            ),
          ),
          SurveyModel(
            label: 'Market research product testing',
            active: true,
            dateModified: '12/01/2020',
            responses: [1, 2, 3],
            project: ProjectModel(
              label: 'Operations VC',
              country: 'Nigeria',
              dateCreated: '10th of January 2020',
              description:
                  'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
            ),
          ),
          SurveyModel(
            label: 'Customer satisfaction template',
            dateModified: '12/01/2020',
            project: ProjectModel(
              label: 'Operations VC',
              country: 'Nigeria',
              dateCreated: '10th of January 2020',
              description:
                  'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
            ),
          ),
          SurveyModel(
            label: 'Customer feedback',
            active: true,
            dateModified: '12/01/2020',
            responses: [1, 2, 3, 4],
            project: ProjectModel(
              label: 'Operations VC',
              country: 'Nigeria',
              dateCreated: '10th of January 2020',
              description:
                  'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
            ),
          ),
        ],
      ),
    ];

    surveys = [
      SurveyModel(
        label: 'Market research product testing',
        active: true,
        dateCreated: '12/01/2020',
        dateModified: '12/01/2020',
        completionTime: '2 mins',
        responses: [1, 2, 3],
        project: ProjectModel(
          label: 'Operations VC',
          country: 'Nigeria',
          dateCreated: '10th of January 2020',
          description:
              'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
        ),
        questions: [
          MultiChoiceQuestionModel(
            question: 'What do you think about Product A?',
            options: [
              OptionModel(id: 1, label: 'I love it'),
              OptionModel(id: 2, label: 'I hate it'),
              OptionModel(id: 3, label: 'I\’m indifferent'),
            ],
          ),
          MultiChoiceQuestionModel(
            question: 'What do you think about Product A?',
            options: [
              OptionModel(id: 1, label: 'I love it'),
              OptionModel(id: 2, label: 'I hate it'),
              OptionModel(id: 3, label: 'I\’m indifferent'),
            ],
          ),
          OpenQuestionModel(question: 'What do you think about Product A?'),
        ],
        collectors: [
          CollectorModel(label: 'Live Survey', responses: [1, 2, 3, 4]),
          CollectorModel(label: 'Link Sharing', responses: [1, 2]),
        ],
      ),
      SurveyModel(
        label: 'Customer satisfaction template',
        dateCreated: '12/01/2020',
        dateModified: '12/01/2020',
        completionTime: '2 mins',
        project: ProjectModel(
          label: 'LAPL - Project SVG',
          country: 'Nigeria',
          dateCreated: '10th of January 2020',
          description:
              'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
        ),
        questions: [
          MultiChoiceQuestionModel(
            question: 'What do you think about Product A?',
            options: [
              OptionModel(id: 1, label: 'I love it'),
              OptionModel(id: 2, label: 'I hate it'),
              OptionModel(id: 3, label: 'I\’m indifferent'),
            ],
          ),
          OpenQuestionModel(question: 'What do you think about Product A?'),
          MultiChoiceQuestionModel(
            question: 'What do you think about Product A?',
            options: [
              OptionModel(id: 1, label: 'I love it'),
              OptionModel(id: 2, label: 'I hate it'),
              OptionModel(id: 3, label: 'I\’m indifferent'),
            ],
          ),
        ],
        collectors: [
          CollectorModel(label: 'Live Survey', responses: [1, 2, 3, 4]),
          CollectorModel(label: 'Link Sharing', responses: [1, 2]),
        ],
      ),
      SurveyModel(
        label: 'Customer feedback',
        active: true,
        dateCreated: '12/01/2020',
        dateModified: '12/01/2020',
        completionTime: '2 mins',
        responses: [1, 2, 3, 4],
        project: ProjectModel(
          label: 'SAPS Project',
          country: 'Nigeria',
          dateCreated: '10th of January 2020',
          description:
              'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
        ),
        questions: [
          OpenQuestionModel(question: 'What do you think about Product A?'),
          MultiChoiceQuestionModel(
            question: 'What do you think about Product A?',
            options: [
              OptionModel(id: 1, label: 'I love it'),
              OptionModel(id: 2, label: 'I hate it'),
              OptionModel(id: 3, label: 'I\’m indifferent'),
            ],
          ),
          MultiChoiceQuestionModel(
            question: 'What do you think about Product A?',
            options: [
              OptionModel(id: 1, label: 'I love it'),
              OptionModel(id: 2, label: 'I hate it'),
              OptionModel(id: 3, label: 'I\’m indifferent'),
            ],
          ),
        ],
        collectors: [
          CollectorModel(label: 'Live Survey', responses: [1, 2, 3, 4]),
          CollectorModel(label: 'Link Sharing', responses: [1, 2]),
        ],
      ),
    ];
  }

  StoreModel.zero() {
    StoreModel._internal();
  }

  factory StoreModel() {
    return _singleton;
  }

  bool _darkMode;
  bool _authenticated;
  bool _processing;
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
  List<ProjectModel> projects;
  List<SurveyModel> surveys;

  bool get isDarkMode => _darkMode == true;

  bool get isAuthenticated => _authenticated;

  bool get isProcessing => _processing;

  set darkMode(bool value) {
    if (_darkMode != value) {
      _darkMode = value;
      _saveThemeMode();
      notifyListeners();
    }
  }

  set processing(bool value) {
    if (_processing != value) {
      _processing = value;
      notifyListeners();
    }
  }

  Future<bool> login() {
    if (user != null || user != UserModel.zero) {
      _authenticated = true;
      notifyListeners();
    }
    return Future.delayed(Duration(seconds: 0), () => _authenticated);
  }

  Future<bool> logout() {
    return Future.delayed(Duration(milliseconds: 500), () {
      if (isAuthenticated) {
        _authenticated = false;
        user = UserModel.zero;
        picture = null;
        notifyListeners();
      }
      return true;
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
