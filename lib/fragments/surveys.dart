import 'package:flutter/material.dart';
import 'package:lime/components/card.dart';
import 'package:lime/components/scaffold.dart';
import 'package:lime/main.dart';
import 'package:lime/models/store.dart';
import 'package:lime/models/survey.dart';
import 'package:lime/values/spacing.dart';
import 'package:lime/views/survey.dart';
import 'package:provider/provider.dart';

class SurveysFragment extends StatefulWidget {
  final Function(int) onNavigate;

  SurveysFragment({Key key, this.onNavigate}) : super(key: key);

  @override
  _SurveysFragmentState createState() => _SurveysFragmentState();
}

class _SurveysFragmentState extends State<SurveysFragment> {
  StoreModel store;

  @override
  void initState() {
    super.initState();
    store = Provider.of<StoreModel>(App.navigatorKey.currentContext);
  }

  @override
  Widget build(BuildContext context) {
    return LScaffold(
      appBar: AppBar(
        title: Text('All Surveys'),
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
                    children: <Widget>[
                      VSpace.md,
                      for (SurveyModel survey in store.surveys)
                        LSurveySummaryCard(
                          survey,
                          context: context,
                          onTap: () {
                            App.pushPageRoute(
                              SurveyView(survey: survey),
                              fullscreenDialog: true,
                            );
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
    );
  }
}
