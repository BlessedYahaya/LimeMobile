import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lime_mobile_app/models/project.dart';
import 'package:lime_mobile_app/models/question.dart';
import 'package:lime_mobile_app/models/survey.dart';
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
  final EdgeInsetsGeometry padding;
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
    this.padding,
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
          padding: flush ? EdgeInsets.all(0) : padding ?? EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}

class LProjectCard extends LCard {
  final ProjectModel project;
  final IconData iconData;
  final Color iconColor;

  LProjectCard(
    this.project, {
    Key key,
    bool flush,
    this.iconData = Icons.folder,
    this.iconColor = LColors.grayColor,
    @required BuildContext context,
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
                  '${project.label}',
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
    @required BuildContext context,
    GestureTapCallback onTap,
    Color color = LColors.primaryColor,
    Color textColor,
    Widget leading,
    Widget trailing,
    String label,
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
                        '$label',
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

class LSummaryCard extends LCard {
  LSummaryCard({
    Key key,
    @required BuildContext context,
    GestureTapCallback onTap,
    Color color = LColors.primaryColor,
    Color textColor,
    @required String value,
    @required String label,
  }) : super(
          key: key,
          color: color,
          onTap: onTap,
          padding: EdgeInsets.all(8),
          child: LimitedBox(
            maxHeight: 80,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Text(
                      '$label',
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontFamily: Strings.app.font,
                            fontWeight: FontWeight.w400,
                            color: textColor,
                          ),
                      maxLines: 2,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                VSpace.sm,
                Text(
                  '${value ?? ''}',
                  style: TextStyle(
                    fontFamily: Strings.app.font,
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    height: 1.33,
                    color: LColors.grayColor,
                  ),
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
    @required BuildContext context,
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

class LProjectDetailsCard extends LCard {
  final ProjectModel project;

  LProjectDetailsCard(
    this.project, {
    Key key,
    @required BuildContext context,
    GestureTapCallback onTap,
  }) : super(
          key: key,
          onTap: onTap,
          child: LimitedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Description:',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                VSpace.sm,
                Text(
                  '${project.description}',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w500,
                      ),
                  softWrap: true,
                ),
                Divider(),
                Text(
                  'Date Started:',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                VSpace.sm,
                Text(
                  '${project.dateCreated}',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w500,
                      ),
                  softWrap: true,
                ),
                Divider(),
                Text(
                  'Country:',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                VSpace.sm,
                Text(
                  '${project.country}',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w500,
                      ),
                  softWrap: true,
                ),
              ],
            ),
          ),
        );
}

class LSurveySummaryCard extends LCard {
  final SurveyModel survey;

  LSurveySummaryCard(
    this.survey, {
    Key key,
    @required BuildContext context,
    GestureTapCallback onTap,
  }) : super(
          key: key,
          onTap: onTap,
          child: LimitedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(Icons.assignment, color: LColors.purpleColor),
                HSpace.sm,
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${survey.label}',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              fontFamily: Strings.app.font,
                              fontWeight: FontWeight.w500,
                            ),
                        softWrap: true,
                      ),
                      if (survey.project != null) ...[
                        VSpace.xs,
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.folder,
                              color: LColors.grayColor,
                              size: 16,
                            ),
                            HSpace.sm,
                            Text(
                              '${survey.project.label}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    fontFamily: Strings.app.font,
                                    fontWeight: FontWeight.w400,
                                    color: LColors.grayColor,
                                  ),
                              softWrap: true,
                            ),
                          ],
                        ),
                      ],
                      VSpace.xs,
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.lens,
                            color: survey.active
                                ? LColors.primaryColor
                                : LColors.purpleColor,
                            size: 16,
                          ),
                          HSpace.sm,
                          Text(
                            '${survey.active ? 'Active' : 'Drafted'} Survey',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontFamily: Strings.app.font,
                                      fontWeight: FontWeight.w400,
                                      color: survey.active
                                          ? LColors.primaryColor
                                          : LColors.purpleColor,
                                    ),
                            softWrap: true,
                          ),
                        ],
                      ),
                      VSpace.md,
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Last modified ${survey.dateModified}',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  fontFamily: Strings.app.font,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                ),
                            softWrap: true,
                          ),
                          Text(
                            '${survey.responses?.length ?? 0} response${survey.responses?.length == 1 ? '' : 's'}',
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  fontFamily: Strings.app.font,
                                  fontWeight: FontWeight.w300,
                                  fontStyle: FontStyle.italic,
                                ),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
}

class LSurveyDetailsCard extends LCard {
  final SurveyModel survey;

  LSurveyDetailsCard(
    this.survey, {
    Key key,
    @required BuildContext context,
    GestureTapCallback onTap,
  }) : super(
          key: key,
          onTap: onTap,
          child: LimitedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Project:',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                VSpace.sm,
                Text(
                  '${survey.project?.label ?? 'N/A'}',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w500,
                      ),
                  softWrap: true,
                ),
                Divider(),
                Text(
                  'No. of Questions:',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                VSpace.sm,
                Text(
                  '${survey.questions?.length ?? 0}',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w500,
                      ),
                  softWrap: true,
                ),
                Divider(),
                Text(
                  'Date Started:',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                VSpace.sm,
                Text(
                  '${survey.dateCreated}',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w500,
                      ),
                  softWrap: true,
                ),
                Divider(),
                Text(
                  'Last Modified:',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                VSpace.sm,
                Text(
                  '${survey.dateModified}',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w500,
                      ),
                  softWrap: true,
                ),
                Divider(),
                Text(
                  'Estimated completion time:',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                VSpace.sm,
                Text(
                  '${survey.completionTime}',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w500,
                      ),
                  softWrap: true,
                ),
              ],
            ),
          ),
        );
}

class LSurveyCollectorsCard extends LCard {
  final SurveyModel survey;

  LSurveyCollectorsCard(
    this.survey, {
    Key key,
    @required BuildContext context,
    GestureTapCallback onTap,
  }) : super(
          key: key,
          onTap: onTap,
          child: LimitedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Live Survey:',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w400,
                        color: LColors.primaryColor,
                      ),
                ),
                VSpace.sm,
                Text(
                  '${survey.responses?.length ?? '0'} response${survey.responses?.length == 1 ? '' : 's'}',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w500,
                      ),
                  softWrap: true,
                ),
                Divider(),
                Text(
                  'Link Sharing:',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w400,
                        color: LColors.primaryColor,
                      ),
                ),
                VSpace.sm,
                Text(
                  '${survey.responses?.length ?? 0} response${survey.responses?.length == 1 ? '' : 's'}',
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w500,
                      ),
                  softWrap: true,
                ),
              ],
            ),
          ),
        );
}

class LQuestionCard extends LCard {
  final QuestionModel question;
  final ValueChanged<OptionModel> onChanged;

  LQuestionCard({
    Key key,
    this.question,
    this.onChanged,
    @required BuildContext context,
    @required int index,
    GestureTapCallback onTap,
  }) : super(
          key: key,
          onTap: onTap,
          child: LimitedBox(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$index.',
                      style: Theme.of(context).textTheme.caption.copyWith(
                            fontFamily: Strings.app.font,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    HSpace.sm,
                    Expanded(
                      child: Text(
                        '${question.question}',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontFamily: Strings.app.font,
                              fontWeight: FontWeight.w500,
                            ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                VSpace.sm,
                for (OptionModel _option in question.options)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Radio<OptionModel>(
                        value: _option,
                        groupValue: question.answer,
                        onChanged: onChanged,
                      ),
                      Expanded(
                        child: Text('${_option.label}', softWrap: true),
                      ),
                    ],
                  ),
                if (question.message != null) ...[
                  VSpace.sm,
                  Text(
                    '${question.message}',
                    style: Theme.of(context).textTheme.caption.copyWith(
                          fontFamily: Strings.app.font,
                          color: Theme.of(context).errorColor,
                          fontWeight: FontWeight.w500,
                        ),
                    softWrap: true,
                  ),
                ],
              ],
            ),
          ),
        );
}

class LOpenQuestionCard extends LCard {
  final OpenQuestionModel question;
  final ValueChanged<String> onChanged;
  final FormFieldValidator<String> validator;

  LOpenQuestionCard({
    Key key,
    @required this.question,
    @required this.onChanged,
    this.validator,
    @required BuildContext context,
    @required int index,
    GestureTapCallback onTap,
  }) : super(
          key: key,
          onTap: onTap,
          child: LimitedBox(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$index.',
                  style: Theme.of(context).textTheme.caption.copyWith(
                        fontFamily: Strings.app.font,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                HSpace.sm,
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${question.question}',
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontFamily: Strings.app.font,
                              fontWeight: FontWeight.w500,
                            ),
                        softWrap: true,
                      ),
                      VSpace.md,
                      LimitedBox(
                          child: TextFormField(
                        validator: validator,
                        minLines: 3,
                        maxLines: 3,
                        onChanged: onChanged,
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
}
