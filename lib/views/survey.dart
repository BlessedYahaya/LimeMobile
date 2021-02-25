import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lime/components/button.dart';
import 'package:lime/components/card.dart';
import 'package:lime/components/scaffold.dart';
import 'package:lime/main.dart';
import 'package:lime/models/question.dart';
import 'package:lime/models/survey.dart';
import 'package:lime/utils.dart';
import 'package:lime/values/colors.dart';
import 'package:lime/values/spacing.dart';
import 'package:lime/views/feedback.dart';

class SurveyView extends StatefulWidget {
  final SurveyModel survey;

  SurveyView({Key key, this.survey})
      : assert(survey != null),
        super(key: key);

  @override
  _SurveyViewState createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TabController tabCtrl;

  @override
  void initState() {
    super.initState();
    tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return LScaffold(
      appBar: AppBar(
        title: Text('${widget.survey.label}'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
        bottom: TabBar(
          controller: tabCtrl,
          onTap: (int index) {
            if (FocusScope.of(context).hasFocus) {
              FocusScope.of(context).unfocus();
            }
          },
          tabs: [
            Tab(text: 'Summary'),
            Tab(text: 'Preview'),
          ],
        ),
      ),
      body: TabBarView(
        controller: tabCtrl,
        physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
        children: [
          CustomScrollView(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            slivers: <Widget>[
              SliverList(
                delegate: SliverChildListDelegate(
                  <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          VSpace.md,
                          Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                LMiniButton(
                                  'New Response',
                                  onPressed: () {
                                    App.pushPageRoute(
                                      FeedbackView(survey: widget.survey),
                                    );
                                  },
                                  icon: Icon(Icons.add, size: 16),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: LSummaryCard(
                                  label: 'Total Responses',
                                  context: context,
                                  color: LColors.primaryLightColor,
                                  value: '${widget.survey.responses ?? 0}',
                                ),
                              ),
                              Expanded(
                                child: LSummaryCard(
                                  label: 'Survey Status',
                                  context: context,
                                  color: LColors.primaryLightColor,
                                  value:
                                      '${(widget.survey.active ?? false) ? 'Active' : 'Draft'}',
                                ),
                              ),
                              Expanded(
                                child: LSummaryCard(
                                  label: 'Collectors',
                                  context: context,
                                  color: LColors.primaryLightColor,
                                  value:
                                      '${widget.survey.collectors?.length ?? 0}',
                                ),
                              ),
                            ],
                          ),
                          VSpace.lg,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  'Details',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'Edit Details',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          color: LColors.purpleColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // TODO: bind with UI
                                        print('TODO');
                                      },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          LSurveyDetailsCard(
                            widget.survey,
                            context: context,
                          ),
                          VSpace.md,
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Collectors',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              LSurveyCollectorsCard(
                                widget.survey,
                                context: context,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          CustomScrollView(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
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
                          Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                if (widget.survey.questions != null)
                                  for (var question
                                      in widget.survey?.questions) ...[
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
                                    if (question is ChecklistQuestionModel)
                                      LChecklistQuestionCard(
                                        question: question,
                                        context: context,
                                        index: widget.survey.questions
                                                .indexOf(question) +
                                            1,
                                        onChanged: (bool value, int index) {
                                          setState(() {
                                            question.options[index].selected =
                                                value;
                                          });
                                        },
                                      ),
                                    if (question is RangeQuestionModel)
                                      LRangeQuestionCard(
                                        question: question,
                                        context: context,
                                        index: widget.survey.questions
                                                .indexOf(question) +
                                            1,
                                        onChanged: (double value) {
                                          setState(() {
                                            question.answer = value.toInt();
                                          });
                                        },
                                      ),
                                  ],
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
        ],
      ),
    );
  }
}
