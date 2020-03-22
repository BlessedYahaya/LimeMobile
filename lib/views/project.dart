import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lime_mobile_app/components/card.dart';
import 'package:lime_mobile_app/components/scaffold.dart';
import 'package:lime_mobile_app/main.dart';
import 'package:lime_mobile_app/models/project.dart';
import 'package:lime_mobile_app/models/survey.dart';
import 'package:lime_mobile_app/values/colors.dart';
import 'package:lime_mobile_app/values/spacing.dart';
import 'package:lime_mobile_app/views/survey.dart';

class ProjectView extends StatefulWidget {
  final ProjectModel project;

  ProjectView({Key key, this.project})
      : assert(project != null),
        super(key: key);

  @override
  _ProjectViewState createState() => _ProjectViewState();
}

class _ProjectViewState extends State<ProjectView>
    with TickerProviderStateMixin {
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
        title: Text('${widget.project.label}'),
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
            Tab(text: 'Surveys'),
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
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                RichText(
                                  text: TextSpan(
                                    text: 'Delete Project',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          color: Theme.of(context).errorColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // TODO: show some dialog
                                        print('TODO');
                                      },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: LSummaryCard(
                                  label: 'Total\nSurveys',
                                  context: context,
                                  color: LColors.primaryLightColor,
                                  value:
                                      '${widget.project.surveys?.length ?? 0}',
                                ),
                              ),
                              Expanded(
                                child: LSummaryCard(
                                  label: 'Active Surveys',
                                  context: context,
                                  color: LColors.primaryLightColor,
                                  value:
                                      '${widget.project.activeSurveys?.length ?? 0}',
                                ),
                              ),
                              Expanded(
                                child: LSummaryCard(
                                  label: 'Draft Surveys',
                                  context: context,
                                  color: LColors.primaryLightColor,
                                  value:
                                      '${widget.project.draftSurveys?.length ?? 0}',
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
                          LProjectDetailsCard(
                            widget.project,
                            context: context,
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
                        children: <Widget>[
                          VSpace.md,
                          for (SurveyModel survey in widget.project.surveys)
                            LSurveySummaryCard(
                              survey,
                              context: context,
                              showProject: false,
                              onTap: () {
                                App.pushPageRoute(SurveyView(survey: survey));
                              },
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
