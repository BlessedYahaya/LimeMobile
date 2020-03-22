import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lime_mobile_app/components/button.dart';
import 'package:lime_mobile_app/components/card.dart';
import 'package:lime_mobile_app/components/scaffold.dart';
import 'package:lime_mobile_app/models/survey.dart';
import 'package:lime_mobile_app/values/colors.dart';
import 'package:lime_mobile_app/values/spacing.dart';

class SurveyView extends StatefulWidget {
  final SurveyModel survey;

  SurveyView({Key key, this.survey})
      : assert(survey != null),
        super(key: key);

  @override
  _SurveyViewState createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> with TickerProviderStateMixin {
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
                                  onPressed: () {},
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
                                  value:
                                      '${widget.survey.responses?.length ?? 0}',
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
                                  style: Theme.of(context).textTheme.subtitle1,
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
                        children: <Widget>[
                          VSpace.md,
                          LSurveySummaryCard(
                            widget.survey,
                            context: context,
                            showProject: false,
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