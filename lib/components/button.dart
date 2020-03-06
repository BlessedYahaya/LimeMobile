import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lime_mobile_app/utils.dart';
import 'package:lime_mobile_app/values/colors.dart';

enum ButtonType { primary, accent, secondary, success }

class TLRaisedButton extends StatefulWidget {
  final String text;
  final ButtonType type;
  final VoidCallback onPressed;
  final EdgeInsets padding;
  final double elevation;

  const TLRaisedButton(
    this.text, {
    Key key,
    @required this.onPressed,
    this.type = ButtonType.primary,
    this.padding = const EdgeInsets.symmetric(horizontal: 64, vertical: 18),
    this.elevation = 8.0,
  }) : super(key: key);

  @override
  _TLRaisedButtonState createState() => _TLRaisedButtonState();
}

class _TLRaisedButtonState extends State<TLRaisedButton> {
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

class TLMiniButton extends StatefulWidget {
  final String text;
  final ButtonType type;
  final VoidCallback onPressed;

  const TLMiniButton(
    this.text, {
    Key key,
    @required this.onPressed,
    this.type = ButtonType.primary,
  }) : super(key: key);

  @override
  _TLMiniButtonState createState() => _TLMiniButtonState();
}

class _TLMiniButtonState extends State<TLMiniButton> {
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
          child: Text(widget.text),
          color: getColor(),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          disabledColor: getColor().withOpacity(0.3),
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
            child: Text(widget.text),
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

class TLFlatButton extends StatefulWidget {
  final String text;
  final ButtonType type;
  final VoidCallback onPressed;
  final EdgeInsets padding;

  const TLFlatButton(
    this.text, {
    Key key,
    @required this.onPressed,
    this.type = ButtonType.primary,
    this.padding = const EdgeInsets.symmetric(horizontal: 64, vertical: 18),
  }) : super(key: key);

  @override
  _TLFlatButtonState createState() => _TLFlatButtonState();
}

class _TLFlatButtonState extends State<TLFlatButton> {
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
