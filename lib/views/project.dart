import 'package:flutter/material.dart';
import 'package:lime_mobile_app/components/card.dart';
import 'package:lime_mobile_app/components/scaffold.dart';
import 'package:lime_mobile_app/models/project.dart';
import 'package:lime_mobile_app/values/colors.dart';

class ProjectFragment extends StatefulWidget {
  final ProjectModel project;

  ProjectFragment({Key key, this.project})
      : assert(project != null),
        super(key: key);

  @override
  _ProjectFragmentState createState() => _ProjectFragmentState();
}

class _ProjectFragmentState extends State<ProjectFragment> {
  @override
  Widget build(BuildContext context) {
    return LScaffold(
      appBar: AppBar(
        title: Text('${widget.project.label}'),
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: LSummaryCard(
                        label: 'Total\nSurveys',
                        context: context,
                        color: LColors.primaryLightColor,
                        value: '${widget.project.surveys?.length ?? 0}',
                      ),
                    ),
                    Expanded(
                      child: LSummaryCard(
                        label: 'Active Surveys',
                        context: context,
                        color: LColors.primaryLightColor,
                        value: '${widget.project.activeSurveys?.length ?? 0}',
                      ),
                    ),
                    Expanded(
                      child: LSummaryCard(
                        label: 'Draft Surveys',
                        context: context,
                        color: LColors.primaryLightColor,
                        value: '${widget.project.draftSurveys?.length ?? 0}',
                      ),
                    ),
                  ],
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
    );
  }
}
