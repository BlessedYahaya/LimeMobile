import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lime/components/busy.dart';
import 'package:lime/components/scaffold.dart';
import 'package:lime/fragments/home.dart';
import 'package:lime/fragments/profile.dart';
import 'package:lime/fragments/projects.dart';
import 'package:lime/fragments/surveys.dart';
import 'package:lime/models/store.dart';
import 'package:lime/utils.dart';
import 'package:lime/values/spacing.dart';
import 'package:lime/values/strings.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  static const String routeName = '/dashboard';

  DashboardView({Key key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  List<Widget> tabs;

  List<BottomNavigationBarItem> navItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: (Strings.dashboard.home),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.work),
      label: (Strings.dashboard.projects),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.assignment),
      label: (Strings.dashboard.surveys),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: (Strings.dashboard.profile),
    ),
  ];

  List<BottomNavigationBarItem> navItemsIos = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      label: (Strings.dashboard.home),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.work),
      label: (Strings.dashboard.projects),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.assignment),
      label: (Strings.dashboard.surveys),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person),
      label: (Strings.dashboard.profile),
    ),
  ];

  int currentTabIndex = 0;

  List<BottomNavigationBarItem> get items =>
      platform() == SystemPlatform.apple ? navItemsIos : navItems;

  @override
  void initState() {
    if (Provider.of<StoreModel>(context, listen: false).surveys == null)
      Provider.of<StoreModel>(context, listen: false).getProjects(context);
    tabs = [
      HomeFragment(onNavigate: onTapped),
      ProjectsFragment(onNavigate: onTapped),
      SurveysFragment(onNavigate: onTapped),
      ProfileFragment(onNavigate: onTapped),
    ];
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    StoreModel store = Provider.of<StoreModel>(context);
    return WillPopScope(
      onWillPop: () async {
        if (currentTabIndex != 0) {
          onTapped(0);
          return false;
        }

        return await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Do you want to quit?'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Yes'),
                  onPressed: () {
                    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                  },
                ),
                RaisedButton(
                  child: Text('No'),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                HSpace.xs,
              ],
            );
          },
        );
      },
      child: BusyWidget(
        busy: store.isProcessing,
        child: LTabScaffold(
          context: context,
          body: tabs[currentTabIndex],
          currentIndex: currentTabIndex,
          items: items,
          onTap: onTapped,
          top: false,
        ),
      ),
    );
  }

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }
}
