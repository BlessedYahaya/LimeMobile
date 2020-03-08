import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lime_mobile_app/models/project.dart';
import 'package:lime_mobile_app/values/colors.dart';
import 'package:lime_mobile_app/values/spacing.dart';
import 'package:lime_mobile_app/values/strings.dart';

class LCard extends StatelessWidget {
  final Color color;
  final double elevation;
  final RoundedRectangleBorder shape;
  final bool borderOnForeground;
  final Clip clipBehavior;
  final EdgeInsetsGeometry margin;
  final bool semanticContainer;
  final bool flush;
  final Widget child;
  final GestureTapCallback onTap;

  const LCard({
    Key key,
    this.color,
    this.elevation = 0,
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(const Radius.circular(10)),
      side: BorderSide(color: LColors.primaryColor, width: 1.5),
    ),
    this.borderOnForeground = true,
    this.flush = false,
    this.clipBehavior,
    this.margin = const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
    this.semanticContainer = true,
    this.child,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      elevation: elevation,
      shape: shape,
      borderOnForeground: borderOnForeground,
      clipBehavior: clipBehavior,
      margin: margin,
      semanticContainer: semanticContainer,
      child: InkWell(
        onTap: onTap,
        borderRadius: shape.borderRadius,
        child: Container(
          padding: EdgeInsets.all(flush ? 0 : 16),
          child: child,
        ),
      ),
    );
  }
}

class LFolderCard extends LCard {
  final ProjectModel folder;
  final IconData iconData;
  final Color iconColor;

  LFolderCard(
    this.folder, {
    Key key,
    bool flush,
    this.iconData = Icons.folder,
    this.iconColor = LColors.grayColor,
    BuildContext context,
    GestureTapCallback onTap,
  }) : super(
          key: key,
          flush: flush ?? false,
          onTap: onTap,
          child: LimitedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Icon(
                    iconData,
                    color: iconColor,
                    size: 28,
                  ),
                ),
                VSpace.md,
                Text(
                  '${folder.label}',
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w400,
                      ),
                  maxLines: 2,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
}

class LButtonCard extends LCard {
  LButtonCard({
    Key key,
    BuildContext context,
    GestureTapCallback onTap,
    Color color = LColors.primaryColor,
    Color textColor,
    Widget leading,
    Widget trailing,
    String text,
  }) : super(
          key: key,
          color: color,
          onTap: onTap,
          child: LimitedBox(
            maxHeight: 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    if (leading != null) leading,
                    HSpace.sm,
                    Expanded(
                      child: Text(
                        '$text',
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              fontFamily: Strings.app.font,
                              fontWeight: FontWeight.w400,
                              color: textColor,
                            ),
                        maxLines: 2,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    HSpace.sm,
                    if (trailing != null) trailing,
                  ],
                ),
              ],
            ),
          ),
        );
}

class LCheckCard extends LCard {
  final bool checked;
  final ValueChanged<bool> onChanged;

  LCheckCard(
    this.checked,
    this.onChanged, {
    Key key,
    BuildContext context,
    GestureTapCallback onTap,
    Color textColor,
    @required String label,
  }) : super(
          key: key,
          flush: true,
          onTap: onTap,
          child: Row(
            children: <Widget>[
              Checkbox(
                value: checked,
                onChanged: onChanged,
              ),
              Expanded(
                child: Text(
                  '$label',
                  maxLines: 1,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
}