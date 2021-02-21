import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lime/utils.dart';
import 'package:lime/values/colors.dart';

class LScaffold extends StatelessWidget {
  /// Cupertino-specific options
  final ObstructingPreferredSizeWidget navigationBar;

  /// Material-specific options
  final bool extendBody;
  final bool extendBodyBehindAppBar;
  final PreferredSizeWidget appBar;
  final Widget body;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final FloatingActionButtonAnimator floatingActionButtonAnimator;
  final List<Widget> persistentFooterButtons;
  final Widget drawer;
  final Widget endDrawer;
  final Color drawerScrimColor;
  final Widget bottomNavigationBar;
  final Widget bottomSheet;
  final bool primary;
  final DragStartBehavior drawerDragStartBehavior;
  final double drawerEdgeDragWidth;

  /// general options
  final bool resizeToAvoidBottomInset;
  final Color backgroundColor;
  final bool left;
  final bool top;
  final bool right;
  final bool bottom;
  final EdgeInsets minimum;

  const LScaffold({
    Key key,
    this.navigationBar,
    this.backgroundColor,
    this.resizeToAvoidBottomInset = true,
    this.extendBody = false,
    this.extendBodyBehindAppBar = false,
    this.appBar,
    this.body,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.floatingActionButtonAnimator,
    this.persistentFooterButtons,
    this.drawer,
    this.endDrawer,
    this.drawerScrimColor,
    this.bottomNavigationBar,
    this.bottomSheet,
    this.primary = true,
    this.drawerDragStartBehavior = DragStartBehavior.start,
    this.drawerEdgeDragWidth,
    this.left = false,
    this.top = true,
    this.right = false,
    this.bottom = true,
    this.minimum = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (platform() == SystemPlatform.apple) {
    //   return CupertinoPageScaffold(
    //     child: SafeArea(
    //       child: body,
    //       left: left,
    //       right: right,
    //       top: top,
    //       bottom: bottom,
    //     ),
    //     backgroundColor: backgroundColor,
    //     navigationBar: navigationBar,
    //     resizeToAvoidBottomInset: resizeToAvoidBottomInset,
    //   );
    // }
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBody: extendBody,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBar,
      body: SafeArea(
        child: body,
        left: left,
        right: right,
        top: top,
        bottom: bottom,
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      floatingActionButtonAnimator: floatingActionButtonAnimator,
      persistentFooterButtons: persistentFooterButtons,
      drawer: drawer,
      endDrawer: endDrawer,
      drawerScrimColor: drawerScrimColor,
      bottomNavigationBar: bottomNavigationBar,
      bottomSheet: bottomSheet,
      primary: primary,
      drawerDragStartBehavior: drawerDragStartBehavior,
      drawerEdgeDragWidth: drawerEdgeDragWidth,
    );
  }
}

class LTabScaffold extends LScaffold {
  /// Cupertino-specific options
  final CupertinoTabBar tabBar;
  final CupertinoTabController controller;
  final IndexedWidgetBuilder tabBuilder;

  /// Android-specific options
  final double elevation;
  final BottomNavigationBarType type;
  final double iconSize;
  final Color selectedItemColor;
  final Color unselectedItemColor;
  final IconThemeData selectedIconTheme;
  final IconThemeData unselectedIconTheme;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;
  final double selectedFontSize;
  final double unselectedFontSize;
  final bool showUnselectedLabels;
  final bool showSelectedLabels;

  Color get fixedColor => selectedItemColor;

  // general options
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int> onTap;
  final int currentIndex;

  LTabScaffold({
    Key key,
    @required BuildContext context,
    // cupertino data
    this.tabBar,
    this.controller,
    this.tabBuilder,
    bool resizeToAvoidBottomInset = true,
    @required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.elevation = 16.0,
    this.type,
    this.iconSize = 24.0,
    this.selectedItemColor = LColors.primaryColor,
    this.unselectedItemColor,
    this.selectedIconTheme = const IconThemeData(),
    this.unselectedIconTheme = const IconThemeData(),
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
    // general data
    Color backgroundColor,
    // super data
    bool extendBody = false,
    bool extendBodyBehindAppBar = false,
    PreferredSizeWidget appBar,
    Widget body,
    Widget floatingActionButton,
    FloatingActionButtonLocation floatingActionButtonLocation,
    FloatingActionButtonAnimator floatingActionButtonAnimator,
    List<Widget> persistentFooterButtons,
    Widget drawer,
    Widget endDrawer,
    Color drawerScrimColor,
    Widget bottomSheet,
    bool primary,
    DragStartBehavior drawerDragStartBehavior,
    double drawerEdgeDragWidth,
    ObstructingPreferredSizeWidget navigationBar,
    bool left = false,
    bool top = true,
    bool right = false,
    bool bottom = true,
    EdgeInsets minimum = EdgeInsets.zero,
  }) : super(
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          extendBody: extendBody,
          extendBodyBehindAppBar: extendBodyBehindAppBar,
          appBar: appBar,
          body: body,
          floatingActionButton: floatingActionButton,
          floatingActionButtonLocation: floatingActionButtonLocation,
          floatingActionButtonAnimator: floatingActionButtonAnimator,
          persistentFooterButtons: persistentFooterButtons,
          drawer: drawer,
          endDrawer: endDrawer,
          drawerScrimColor: drawerScrimColor,
          bottomNavigationBar: BottomNavigationBar(
            items: items,
            backgroundColor: backgroundColor,
            onTap: onTap,
            elevation: elevation,
            currentIndex: currentIndex,
            selectedItemColor: selectedItemColor,
            iconSize: iconSize,
            selectedFontSize: selectedFontSize,
            unselectedItemColor: unselectedItemColor ??
                Theme.of(context).textTheme.bodyText1.color,
            selectedIconTheme: selectedIconTheme,
            unselectedIconTheme: unselectedIconTheme,
            unselectedFontSize: unselectedFontSize,
            selectedLabelStyle: selectedLabelStyle,
            unselectedLabelStyle: unselectedLabelStyle,
            showSelectedLabels: showSelectedLabels,
            showUnselectedLabels: showUnselectedLabels,
          ),
          bottomSheet: bottomSheet,
          primary: primary ?? true,
          drawerDragStartBehavior:
              drawerDragStartBehavior ?? DragStartBehavior.start,
          drawerEdgeDragWidth: drawerEdgeDragWidth,
          navigationBar: navigationBar,
          backgroundColor: backgroundColor,
          left: left,
          top: top,
          right: right,
          bottom: bottom,
          minimum: minimum,
        );

  @override
  Widget build(BuildContext context) {
    return platformWidget(
      android: super.build(context),
      ios: CupertinoTabScaffold(
        backgroundColor: backgroundColor,
        tabBar: CupertinoTabBar(
          items: items,
          backgroundColor: backgroundColor,
          onTap: onTap,
          currentIndex: currentIndex,
          activeColor: selectedItemColor,
          inactiveColor: unselectedItemColor ??
              Theme.of(context).textTheme.bodyText1.color,
          iconSize: iconSize,
        ),
        controller: controller,
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(builder: (context) {
            return super.build(context);
          });
        },
      ),
    );
  }
}
