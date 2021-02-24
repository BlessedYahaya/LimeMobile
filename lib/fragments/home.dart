import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lime/components/card.dart';
import 'package:lime/components/scaffold.dart';
import 'package:lime/main.dart';
import 'package:lime/models/project.dart';
import 'package:lime/models/store.dart';
import 'package:lime/models/survey.dart';
import 'package:lime/values/colors.dart';
import 'package:lime/values/spacing.dart';
import 'package:lime/values/strings.dart';
import 'package:lime/views/project.dart';
import 'package:lime/views/survey.dart';
import 'package:provider/provider.dart';

class HomeFragment extends StatefulWidget {
  HomeFragment({Key key, this.onNavigate}) : super(key: key);

  final Function(int) onNavigate;

  @override
  _HomeFragmentState createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  final ScrollController projectsController =
      ScrollController(keepScrollOffset: true);
  final ScrollController surveysController =
      ScrollController(keepScrollOffset: true);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var store = Provider.of<StoreModel>(context);
    return LScaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: (store.projects) == null && store.isProcessing
      // TODO: handle error case
          ? Container()
          : CustomScrollView(
              physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics()),
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildListDelegate(<Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          VSpace.md,
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 32,
                                height: 32,
                                margin: EdgeInsets.symmetric(horizontal: 8),
                                child: CircleAvatar(
                                  child: (store.user.picture == null ||
                                          store.user.picture.isEmpty)
                                      ? Icon(
                                          Icons.person,
                                          color: Colors.white,
                                          size: 16,
                                        )
                                      : null,
                                  backgroundColor: LColors.purpleColor,
                                  backgroundImage:
                                      (store.user.picture == null ||
                                              store.user.picture.isEmpty)
                                          ? null
                                          : MemoryImage(store.picture),
                                ),
                              ),
                              Text('Hello, ${store.user.firstName}'),
                            ],
                          ),
                          VSpace.md,
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                child: LButtonCard(
                                  label: 'New Responses',
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
                                  label: 'Add live response',
                                  context: context,
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
                                  'Recent Projects',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'See All',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          color: LColors.purpleColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        widget.onNavigate(1);
                                      },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
//                        GestureDetector(
//                          onTap: () {
//                            final double prev = max<double>(
//                                projectsController.position.extentBefore -
//                                    projectsController.position.extentInside,
//                                projectsController.position.minScrollExtent);
//                            projectsController.animateTo(
//                              prev,
//                              duration: Duration(
//                                  milliseconds: prev >= 200 ? 500 : 250),
//                              curve: Curves.easeOut,
//                            );
//                          },
//                          child: Container(
//                            height: 140,
//                            width: 24,
//                            child: Center(
//                              child: Icon(Icons.chevron_left),
//                            ),
//                          ),
//                        ),
                              Expanded(
                                child: LimitedBox(
                                  maxHeight: 140,
                                  child: ListView(
                                    key: PageStorageKey<String>(
                                        'projects-horiz-list'),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    controller: projectsController,
                                    physics: AlwaysScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics(),
                                    ),
                                    children: <Widget>[
                                      for (ProjectModel project
                                          in store.projects.take(5))
                                        LProjectCard(
                                          project,
                                          context: context,
                                          onTap: () {
                                            App.pushPageRoute(
                                              ProjectView(project: project),
                                              fullscreenDialog: true,
                                            );
                                          },
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  final double next = min<double>(
                                      projectsController.position.extentBefore +
                                          projectsController
                                              .position.extentInside,
                                      projectsController
                                          .position.maxScrollExtent);
                                  projectsController.animateTo(
                                    next,
                                    duration: Duration(
                                        milliseconds: next >= 200 ? 500 : 250),
                                    curve: Curves.easeOut,
                                  );
                                },
                                child: Container(
                                  height: 140,
                                  width: 24,
                                  child: Center(
                                    child: Icon(Icons.chevron_right),
                                  ),
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
                                  'Recent Surveys',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontWeight: FontWeight.bold),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: 'See All',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          color: LColors.purpleColor,
                                          decoration: TextDecoration.underline,
                                        ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        widget.onNavigate(2);
                                      },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: <Widget>[
//                        GestureDetector(
//                          onTap: () {
//                            final double prev = max<double>(
//                                surveysController.position.extentBefore -
//                                    surveysController.position.extentInside,
//                                surveysController.position.minScrollExtent);
//                            surveysController.animateTo(
//                              prev,
//                              duration: Duration(
//                                  milliseconds: prev >= 200 ? 500 : 250),
//                              curve: Curves.easeOut,
//                            );
//                          },
//                          child: Container(
//                            height: 140,
//                            width: 24,
//                            child: Center(
//                              child: Icon(Icons.chevron_left),
//                            ),
//                          ),
//                        ),
                              Expanded(
                                child: LimitedBox(
                                  maxHeight: 140,
                                  child: ListView(
                                    key: PageStorageKey<String>(
                                        'surveys-horiz-list'),
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    controller: surveysController,
                                    physics: AlwaysScrollableScrollPhysics(
                                      parent: BouncingScrollPhysics(),
                                    ),
                                    children: <Widget>[
                                      for (SurveyModel survey
                                          in store.surveys?.take(5))
                                        LSurveyCard(
                                          survey,
                                          context: context,
                                          iconData: Icons.assignment,
                                          iconColor: LColors.purpleColor,
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
                              ),
                              GestureDetector(
                                onTap: () {
                                  final double next = min<double>(
                                      surveysController.position.extentBefore +
                                          surveysController
                                              .position.extentInside,
                                      surveysController
                                          .position.maxScrollExtent);
                                  surveysController.animateTo(
                                    next,
                                    duration: Duration(
                                        milliseconds: next >= 200 ? 500 : 250),
                                    curve: Curves.easeOut,
                                  );
                                },
                                child: Container(
                                  height: 140,
                                  width: 24,
                                  child: Center(
                                    child: Icon(Icons.chevron_right),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ]),
                ),
              ],
            ),
    );
  }
}
