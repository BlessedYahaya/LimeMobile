import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lime_mobile_app/utils.dart';

class TLNav extends StatefulWidget {
  /// Cupertino-specific options
  final Widget leading;
  final bool automaticallyImplyLeading;
  final bool automaticallyImplyMiddle;
  final String previousPageTitle;
  final Widget middle;
  final Widget trailing;
  final Brightness brightness;
  final EdgeInsetsDirectional padding;
  final Border border;
  final bool transitionBetweenRoutes;
  final Object heroTag;

  /// Android-specific options
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int> onTap;
  final int currentIndex;
  final double elevation;
  final BottomNavigationBarType type;

  Color get fixedColor => selectedItemColor;
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

  /// general options
  final Color backgroundColor;

  TLNav({
    Key key,
    @required this.items,
    this.leading,
    this.automaticallyImplyLeading,
    this.automaticallyImplyMiddle,
    this.previousPageTitle,
    this.middle,
    this.trailing,
    this.brightness,
    this.padding,
    this.border,
    this.transitionBetweenRoutes,
    this.heroTag,
    this.onTap,
    this.currentIndex = 0,
    this.elevation = 8.0,
    this.type,
    this.backgroundColor,
    this.iconSize = 24.0,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme = const IconThemeData(),
    this.unselectedIconTheme = const IconThemeData(),
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels = true,
    this.showUnselectedLabels,
  });

  @override
  _TLNavState createState() => _TLNavState();
}

class _TLNavState extends State<TLNav> {
  @override
  Widget build(BuildContext context) {
    if (platform() == SystemPlatform.apple) return CupertinoNavigationBar();
    return platformWidget(
      android: BottomNavigationBar(items: widget.items),
      ios: CupertinoNavigationBar(),
    );
  }
}
