import 'package:flutter/material.dart';
import 'package:lime_mobile_app/components/button.dart';
import 'package:lime_mobile_app/components/card.dart';
import 'package:lime_mobile_app/components/scaffold.dart';
import 'package:lime_mobile_app/models/project.dart';
import 'package:lime_mobile_app/models/question.dart';
import 'package:lime_mobile_app/models/survey.dart';
import 'package:lime_mobile_app/utils.dart';
import 'package:lime_mobile_app/values/colors.dart';
import 'package:lime_mobile_app/values/strings.dart';

class ExampleFragment extends StatefulWidget {
  ExampleFragment({Key key}) : super(key: key);

  @override
  _ExampleFragmentState createState() => _ExampleFragmentState();
}

class _ExampleFragmentState extends State<ExampleFragment> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _checked = false;
  MultiChoiceQuestionModel question = MultiChoiceQuestionModel(
    question: 'What do you think about Product A?',
    options: [
      OptionModel(id: 1, label: 'I love it'),
      OptionModel(id: 2, label: 'I hate it'),
      OptionModel(id: 3, label: 'I\’m indifferent'),
    ],
  );
  OpenQuestionModel openQuestion =
      OpenQuestionModel(question: 'What do you think about Product A?');

  bool get checked => _checked;

  bool get _formValid => _formKey.currentState.validate() && question.answered;

  @override
  Widget build(BuildContext context) {
    return LScaffold(
      appBar: AppBar(
        title: Text('Lime'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(<Widget>[
              Column(
                children: <Widget>[
                  LMiniButton('Mini Button', onPressed: null),
                  LMiniButton('Mini Button', onPressed: () {}),
                  LMiniButton(
                    'Mini Button',
                    onPressed: null,
                    icon: Icon(Icons.add, size: 16),
                  ),
                  LMiniButton(
                    'Mini Button',
                    onPressed: () {},
                    icon: Icon(Icons.add, size: 16),
                  ),
                  LMiniFlatButton('Mini Flat Button', onPressed: null),
                  LMiniFlatButton('Mini Flat Button', onPressed: () {}),
                  LCard(child: Text('Plain Card')),
                  LCheckCard(
                    checked,
                    (bool value) {
                      setState(() {
                        _checked = value;
                      });
                    },
                    label: 'LAPL - Project SVG',
                    context: context,
                  ),
                  LCard(
                    flush: true,
                    onTap: () {},
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          value: checked,
                          onChanged: (bool value) {
                            setState(() {
                              _checked = value;
                            });
                          },
                        ),
                        Expanded(
                          child: Text(
                            'Plain Card',
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: LProjectCard(
                          ProjectModel(label: 'SAPS Project'),
                          context: context,
                        ),
                      ),
                      Expanded(
                        child: LProjectCard(
                          ProjectModel(label: 'Operations VC'),
                          context: context,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: LProjectCard(
                          ProjectModel(
                            label: 'Market research product testing',
                          ),
                          context: context,
                          iconData: Icons.assignment,
                          iconColor: LColors.purpleColor,
                        ),
                      ),
                      Expanded(
                        child: LProjectCard(
                          ProjectModel(label: 'Operations VC'),
                          context: context,
                          iconData: Icons.assignment,
                          iconColor: LColors.purpleColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: LButtonCard(
                          label: 'New Responses goes here',
                          context: context,
                          color: LColors.primaryLightColor,
                          trailing: Text(
                            '20',
                            style: TextStyle(
                              fontFamily: Strings.app.font,
                              fontWeight: FontWeight.w700,
                              fontSize: 24,
                              height: 1.33,
                              color: LColors.grayColor,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: LButtonCard(
                          label: 'SAPS Project',
                          context: context,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: LSummaryCard(
                          label: 'Total\nSurveys',
                          context: context,
                          color: LColors.primaryLightColor,
                          value: '20',
                        ),
                      ),
                      Expanded(
                        child: LSummaryCard(
                          label: 'Active Surveys',
                          context: context,
                          color: LColors.primaryLightColor,
                          value: '20',
                        ),
                      ),
                      Expanded(
                        child: LSummaryCard(
                          label: 'Draft Surveys',
                          context: context,
                          color: LColors.primaryLightColor,
                          value: '20',
                        ),
                      ),
                    ],
                  ),
                  LProjectDetailsCard(
                    ProjectModel(
                      label: 'Operations VC',
                      country: 'Nigeria',
                      dateCreated: '10th of January 2020',
                      description:
                          'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
                    ),
                    context: context,
                  ),
                  LSurveySummaryCard(
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
                    context: context,
                  ),
                  LSurveySummaryCard(
                    SurveyModel(
                      label: 'Market research product testing',
                      active: false,
                      dateModified: '12/01/2020',
                      responses: [1],
                      project: ProjectModel(
                        label: 'Operations VC',
                        country: 'Nigeria',
                        dateCreated: '10th of January 2020',
                        description:
                            'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
                      ),
                    ),
                    context: context,
                  ),
                  LSurveySummaryCard(
                    SurveyModel(
                      label: 'Market research product testing',
                      active: false,
                      dateModified: '12/01/2020',
                    ),
                    context: context,
                  ),
                  LSurveyDetailsCard(
                    SurveyModel(
                      label: 'Market research product testing',
                      active: false,
                      dateModified: '14th of January 2020',
                      dateCreated: '10th of January 2020',
                      completionTime: '2 mins',
                      questions: [],
                      project: ProjectModel(
                        label: 'Operations VC',
                        country: 'Nigeria',
                        dateCreated: '10th of January 2020',
                        description:
                            'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
                      ),
                    ),
                    context: context,
                  ),
                  LSurveyCollectorsCard(
                    SurveyModel(
                      label: 'Market research product testing',
                      active: false,
                      dateModified: '14th of January 2020',
                      dateCreated: '10th of January 2020',
                      completionTime: '2 mins',
                      questions: [],
                      responses: [1, 2, 3],
                      project: ProjectModel(
                        label: 'Operations VC',
                        country: 'Nigeria',
                        dateCreated: '10th of January 2020',
                        description:
                            'The project is to ascetain the custlomer satisfaction level of the clients of SAPS',
                      ),
                    ),
                    context: context,
                  ),
                  LQuestionCard(
                    question: question,
                    onChanged: (OptionModel option) {
                      setState(() {
                        if (question.answer != null) {
                          question.answer.selected = false;
                        } else {
                          question.message = null;
                        }
                        option.selected = true;
                      });
                    },
                    context: context,
                    index: 1,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        LOpenQuestionCard(
                          question: openQuestion,
                          onChanged: (String value) {
                            openQuestion.answer = value;
                          },
                          validator: (String value) =>
                              validateRequired(value, 'This'),
                          context: context,
                          index: 2,
                        ),
                        LOpenQuestionCard(
                          question: openQuestion,
                          onChanged: (String value) {
                            openQuestion.answer = value;
                          },
                          context: context,
                          index: 3,
                        ),
                        LMiniButton(
                          'Submit',
                          icon: Icon(Icons.add, size: 16),
                          onPressed: () {
                            setState(() {
                              if (!question.answered) {
                                question.message =
                                    'Choose an option to proceed';
                              } else {
                                question.message = null;
                              }
                            });
                            if (_formValid) {
                              _formKey.currentState.reset();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
