import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lime_mobile_app/components/scaffold.dart';
import 'package:lime_mobile_app/fragments/example.dart';
import 'package:lime_mobile_app/fragments/home.dart';
import 'package:lime_mobile_app/fragments/projects.dart';
import 'package:lime_mobile_app/fragments/surveys.dart';
import 'package:lime_mobile_app/main.dart';
import 'package:lime_mobile_app/models/store.dart';
import 'package:lime_mobile_app/utils.dart';
import 'package:lime_mobile_app/values/strings.dart';
import 'package:provider/provider.dart';

class DashboardView extends StatefulWidget {
  static const String routeName = '/dashboard';

  DashboardView({Key key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  StoreModel store;

  List<Widget> tabs;

  List<BottomNavigationBarItem> navItems = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text(Strings.dashboard.home),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.work),
      title: Text(Strings.dashboard.projects),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.assignment),
      title: Text(Strings.dashboard.surveys),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      title: Text(Strings.dashboard.profile),
    ),
  ];

  List<BottomNavigationBarItem> navItemsIos = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text(Strings.dashboard.home),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.work),
      title: Text(Strings.dashboard.projects),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.assignment),
      title: Text(Strings.dashboard.surveys),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.person),
      title: Text(Strings.dashboard.profile),
    ),
  ];

  int currentTabIndex = 0;

  List<BottomNavigationBarItem> get items =>
      platform() == SystemPlatform.apple ? navItemsIos : navItems;

  @override
  void initState() {
    super.initState();
    store = Provider.of<StoreModel>(App.navigatorKey.currentContext);
    tabs = [
      HomeFragment(onNavigate: onTapped),
      ProjectsFragment(onNavigate: onTapped),
      SurveysFragment(onNavigate: onTapped),
      ExampleFragment(),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LTabScaffold(
      context: context,
      body: tabs[currentTabIndex],
      currentIndex: currentTabIndex,
      items: items,
      onTap: onTapped,
      top: false,
    );
  }

  onTapped(int index) {
    setState(() {
      currentTabIndex = index;
    });
  }
}

class TabViewModel {
  final Widget component;
  final PreferredSizeWidget appBar;
  final ObstructingPreferredSizeWidget navigationBar;

  TabViewModel({@required this.component, this.appBar, this.navigationBar});
}
