import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lime_mobile_app/utils.dart';
import 'package:lime_mobile_app/values/colors.dart';

enum ButtonType { primary, accent, secondary, success }

class LRaisedButton extends StatefulWidget {
  final String text;
  final ButtonType type;
  final VoidCallback onPressed;
  final EdgeInsets padding;
  final double elevation;

  const LRaisedButton(
    this.text, {
    Key key,
    @required this.onPressed,
    this.type = ButtonType.primary,
    this.padding = const EdgeInsets.symmetric(horizontal: 64, vertical: 18),
    this.elevation = 8.0,
  }) : super(key: key);

  @override
  _LRaisedButtonState createState() => _LRaisedButtonState();
}

class _LRaisedButtonState extends State<LRaisedButton> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return platformWidget(
      android: Container(
        margin: EdgeInsets.symmetric(
            horizontal: widget.elevation, vertical: widget.elevation),
        child: RaisedButton(
          child: Text(widget.text),
          color: getColor(),
          padding: widget.padding,
          disabledColor: getColor().withOpacity(0.3),
          highlightColor: getColor().withOpacity(0.5),
          elevation: widget.onPressed == null
              ? 0
              : widget.type == ButtonType.secondary ? 0 : widget.elevation,
          onPressed: widget.onPressed,
        ),
      ),
      ios: Container(
        margin: EdgeInsets.symmetric(
          vertical: widget.elevation,
          horizontal: widget.elevation,
        ),
        child: Material(
          elevation: widget.onPressed == null
              ? 0
              : widget.type == ButtonType.secondary ? 0 : widget.elevation,
          color: widget.onPressed == null
              ? getColor().withOpacity(0.3)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          ),
          child: CupertinoButton(
            child: Text(widget.text),
            color: getColor(),
            padding: widget.padding,
            borderRadius: BorderRadius.circular(22.0),
            onPressed: widget.onPressed,
          ),
        ),
      ),
    );
  }

  Color getColor() {
    switch (widget.type) {
      case ButtonType.accent:
      case ButtonType.secondary:
      default:
        return LColors.primaryColor;
    }
  }
}

class LMiniButton extends StatefulWidget {
  final String text;
  final ButtonType type;
  final Widget icon;
  final VoidCallback onPressed;

  const LMiniButton(
    this.text, {
    Key key,
    this.icon,
    @required this.onPressed,
    this.type = ButtonType.primary,
  }) : super(key: key);

  @override
  _LMiniButtonState createState() => _LMiniButtonState();
}

class _LMiniButtonState extends State<LMiniButton> {
  final double _elevation = 8.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return platformWidget(
      android: Container(
        margin:
            EdgeInsets.symmetric(horizontal: _elevation, vertical: _elevation),
        child: FlatButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              if (widget.icon != null) ...[
                widget.icon,
                const SizedBox(width: 8.0),
              ],
              Text(widget.text),
            ],
          ),
          color: getColor(),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          disabledColor: getColor().withOpacity(0.3),
          highlightColor: getColor().withOpacity(0.5),
          onPressed: widget.onPressed,
        ),
      ),
      ios: Container(
        margin: EdgeInsets.symmetric(horizontal: _elevation, vertical: 0),
        child: Material(
          color: widget.onPressed == null
              ? getColor().withOpacity(0.3)
              : Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          ),
          child: CupertinoButton(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                if (widget.icon != null) ...[
                  widget.icon,
                  const SizedBox(width: 8.0),
                ],
                Text(widget.text),
              ],
            ),
            color: getColor(),
            minSize: 32,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            borderRadius: BorderRadius.circular(22.0),
            onPressed: widget.onPressed,
          ),
        ),
      ),
    );
  }

  Color getColor() {
    switch (widget.type) {
      case ButtonType.success:
      case ButtonType.accent:
      case ButtonType.secondary:
      default:
        return LColors.primaryColor;
    }
  }
}

class LMiniFlatButton extends StatefulWidget {
  final String text;
  final ButtonType type;
  final VoidCallback onPressed;

  const LMiniFlatButton(
    this.text, {
    Key key,
    @required this.onPressed,
    this.type = ButtonType.primary,
  }) : super(key: key);

  @override
  _LMiniFlatButtonState createState() => _LMiniFlatButtonState();
}

class _LMiniFlatButtonState extends State<LMiniFlatButton> {
  final double _elevation = 8.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return platformWidget(
      android: Container(
        margin:
            EdgeInsets.symmetric(horizontal: _elevation, vertical: _elevation),
        child: FlatButton(
          child: Text(
            widget.text,
            style: TextStyle(decoration: TextDecoration.underline),
          ),
          color: Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          disabledColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onPressed: widget.onPressed,
        ),
      ),
      ios: Container(
        margin: EdgeInsets.symmetric(horizontal: _elevation, vertical: 0),
        child: Material(
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          ),
          child: CupertinoButton(
            child: Text(
              widget.text,
              style: TextStyle(decoration: TextDecoration.underline),
            ),
            color: Colors.transparent,
            minSize: 32,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            borderRadius: BorderRadius.circular(22.0),
            onPressed: widget.onPressed,
          ),
        ),
      ),
    );
  }

  Color getColor() {
    switch (widget.type) {
      case ButtonType.success:
      case ButtonType.accent:
      case ButtonType.secondary:
      default:
        return LColors.primaryColor;
    }
  }
}

class LFlatButton extends StatefulWidget {
  final String text;
  final ButtonType type;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  const LFlatButton(
    this.text, {
    Key key,
    @required this.onPressed,
    this.type = ButtonType.primary,
    this.padding = const EdgeInsets.symmetric(horizontal: 64, vertical: 18),
  }) : super(key: key);

  @override
  _LFlatButtonState createState() => _LFlatButtonState();
}

class _LFlatButtonState extends State<LFlatButton> {
  final double _elevation = 8.0;
  TextStyle textStyle;

  @override
  void didChangeDependencies() {
    textStyle = Theme.of(context).textTheme.button.copyWith(color: getColor());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return platformWidget(
      android: Container(
        margin:
            EdgeInsets.symmetric(horizontal: _elevation, vertical: _elevation),
        child: FlatButton(
          child: Text(widget.text, style: textStyle),
          color: Colors.transparent,
          padding: widget.padding,
          highlightColor: getColor().withOpacity(0.2),
          onPressed: widget.onPressed,
        ),
      ),
      ios: Container(
        margin: EdgeInsets.symmetric(
          vertical: _elevation,
          horizontal: _elevation,
        ),
        child: Material(
          elevation: 0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22.0),
          ),
          child: CupertinoButton(
            child: Text(widget.text, style: textStyle),
            color: Colors.transparent,
            padding: widget.padding,
            borderRadius: BorderRadius.circular(22.0),
            onPressed: widget.onPressed,
          ),
        ),
      ),
    );
  }

  Color getColor() {
    switch (widget.type) {
      case ButtonType.accent:
      case ButtonType.secondary:
      default:
        return LColors.primaryColor;
    }
  }
}
