import 'package:flutter/material.dart';
import 'package:lime_mobile_app/components/button.dart';
import 'package:lime_mobile_app/components/card.dart';
import 'package:lime_mobile_app/components/scaffold.dart';
import 'package:lime_mobile_app/models/question.dart';
import 'package:lime_mobile_app/models/survey.dart';
import 'package:lime_mobile_app/utils.dart';
import 'package:lime_mobile_app/values/colors.dart';
import 'package:lime_mobile_app/values/spacing.dart';

class FeedbackView extends StatefulWidget {
  final SurveyModel survey;

  FeedbackView({Key key, this.survey})
      : assert(survey != null),
        super(key: key);

  @override
  _FeedbackViewState createState() => _FeedbackViewState();
}

class _FeedbackViewState extends State<FeedbackView>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formKeyNote = GlobalKey<FormState>();
  bool addNote = false;
  String oldNote = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LScaffold(
      appBar: AppBar(
        title: Text('${widget.survey.label}'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: CustomScrollView(
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      VSpace.md,
                      if (!addNote)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              LMiniButton(
                                '${widget.survey.hasNote ? 'View' : 'Add'} Note',
                                onPressed: () {
                                  setState(() {
                                    addNote = true;
                                  });
                                },
                                icon: Icon(
                                    widget.survey.hasNote
                                        ? Icons.note
                                        : Icons.note_add,
                                    size: 16),
                              ),
                            ],
                          ),
                        ),
                      if (addNote) ...[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                          ),
                          child: Text(
                            'Note details',
                            style: Theme.of(context).textTheme.subtitle1,
                            softWrap: true,
                          ),
                        ),
                        LCard(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              const Radius.circular(10),
                            ),
                            side: BorderSide(
                              color: LColors.grayColor.withOpacity(0.3),
                              width: 1.5,
                            ),
                          ),
                          child: LimitedBox(
                            child: Form(
                              key: _formKeyNote,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Stack(
                                    overflow: Overflow.visible,
                                    children: <Widget>[
                                      LimitedBox(
                                        child: TextFormField(
                                          controller: TextEditingController(
                                              text: widget.survey.note ?? ''),
                                          minLines: 3,
                                          maxLines: 3,
                                          validator: (String value) =>
                                              validateRequired(value, 'Note'),
                                          decoration: InputDecoration(
                                            hintText: 'Add note',
                                          ),
                                          onChanged: (String value) {
                                            widget.survey.note = value;
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        right: -24,
                                        top: -24,
                                        child: IconButton(
                                          icon: Center(
                                            child: Icon(
                                              Icons.cancel,
                                              color: Theme.of(context)
                                                  .errorColor
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          tooltip: 'Cancel note',
                                          onPressed: () {
                                            setState(() {
                                              addNote = false;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  VSpace.md,
                                  LMiniButton(
                                    '${widget.survey.hasNote ? 'Update' : 'Save'} Note',
                                    elevation: 0,
                                    onPressed: () {
                                      if (_formKeyNote.currentState
                                          .validate()) {
                                        setState(() {
                                          addNote = false;
                                        });
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            for (var question in widget.survey.questions) ...[
                              if (question is OpenQuestionModel)
                                LOpenQuestionCard(
                                  question: question,
                                  onChanged: (String value) {
                                    question.answer = value;
                                  },
                                  validator: (String value) =>
                                      validateRequired(value, 'This'),
                                  context: context,
                                  index: widget.survey.questions
                                          .indexOf(question) +
                                      1,
                                ),
                              if (question is MultiChoiceQuestionModel)
                                LQuestionCard(
                                  question: question,
                                  context: context,
                                  index: widget.survey.questions
                                          .indexOf(question) +
                                      1,
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
                                ),
                            ],
                            LMiniButton(
                              'Submit',
                              icon: Icon(Icons.send, size: 16),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
