import 'dart:io';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

enum SystemPlatform { apple, google, microsoft, linux, unknown }

SystemPlatform platform() {
  if (Platform.isIOS || Platform.isMacOS) {
    return SystemPlatform.apple;
  } else if (Platform.isWindows) {
    return SystemPlatform.microsoft;
  } else if (Platform.isAndroid || Platform.isFuchsia) {
    return SystemPlatform.google;
  } else if (Platform.isLinux) {
    return SystemPlatform.linux;
  }

  return SystemPlatform.unknown;
}

Widget platformWidget({Widget android, Widget ios}) {
  assert(android != null);
  assert(ios != null);

  if (platform() == SystemPlatform.apple) {
    return ios;
  }
  return android;
}

TextSpan formatLinks(
    {@required String input, TextStyle textStyle, TextStyle linkStyle}) {
  if (input == null) {
    return TextSpan(text: '');
  }
  RegExp re = RegExp(
      r"(((ht|f)tp(s?)://)|www.)[0-9a-zA-Z]([-.\w]*[0-9a-zA-Z])*(:(0-9)*)*/?([a-zA-Z0-9\-.\?,'/\\\+&amp;%\$#_=]*)?");

  // if there is no match, return the full text
  if (!re.hasMatch(input)) {
    return TextSpan(text: input, style: textStyle);
  }

  List<String> texts = input.split(re);
  List<TextSpan> spans = [];
  List<RegExpMatch> links = re.allMatches(input).toList();

  for (String text in texts) {
    spans.add(TextSpan(text: text, style: textStyle));
    if (links.length > 0) {
      RegExpMatch match = links.removeAt(0);
      String link = match.input.substring(match.start, match.end);

      // add the link
      spans.add(
        TextSpan(
          text: link,
          style: linkStyle,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              String l = link.startsWith('www') ? 'http://$link' : link;
              if (l.endsWith('.') || l.endsWith(',') || l.endsWith(';')) {
                l = l.substring(0, l.length - 1);
              }
              launchURL(l);
            },
        ),
      );
    }
  }

  return TextSpan(children: spans);
}

launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

String validateEmail(String email, {String label = 'Email'}) {
  if (email == null || email.trim() == '') {
    return '$label is required';
  }
  email = email.trim();
  if (RegExp('[^a-zA-Z0-9.@]').hasMatch(email)) {
    return 'Only letters, numbers, & periods are allowed.';
  }
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(email)) {
    if (email.indexOf('@') > -1) {
      String username = email.substring(0, email.indexOf('@'));
      if (username.endsWith('.')) {
        return 'Email username cannot end with a period';
      }
    }
    return 'Enter a valid $label address';
  }

  return null;
}

String validatePassword(String password) {
  if (password == null || password == '') {
    return 'Password is required';
  } else if (password.length < 5) {
    return 'Use 5 characters or more for password';
  } else if (['password', 'Password', '12345', '123456', '12345678']
      .contains(password)) {
    return 'Use a more secure (strong) password';
  }

  return null;
}

String validateUsername(String username) {
  if (username == null || username.trim() == '') {
    return 'Username is required';
  }
  username = username.trim();
  if (RegExp('[^a-zA-Z0-9_]').hasMatch(username)) {
    return 'Only letters, numbers, & underscores are allowed.';
  }
  Pattern pattern = r'^(admin|administrator|sex|fuck|vagina|pussy)$';
  RegExp regex = RegExp(pattern);
  if (regex.hasMatch(username)) {
    return 'Enter a valid username';
  }
  if (RegExp(r'^(_)+$').hasMatch(username)) {
    return 'Username cannot be all underscores';
  }

  return null;
}

String validateNumber(String val, {String label = 'This'}) {
  if (val == null || val.trim() == '') {
    return '$label is required';
  }
  val = val.trim();
  if (RegExp('[^eE0-9\s,.\-]').hasMatch(val)) {
    return 'Only numbers are allowed.';
  }
  if (RegExp('(-){2, }').hasMatch(val)) {
    return '$label should only begin with and contain a single minus (-) sign.';
  }
  if (!RegExp('^(-){1}').hasMatch(val) && RegExp('(-)+').hasMatch(val)) {
    return '$label should only begin with and contain a single minus (-) sign.';
  }
  if (RegExp('^(-){1}').hasMatch(val) && RegExp('(-){2,}').hasMatch(val)) {
    return '$label should only begin with and contain a single minus (-) sign.';
  }

  return null;
}

String validatePositiveNumber(String val,
    {String label = 'This', bool required = true}) {
  if (required && (val == null || val.trim() == '')) {
    return '$label is required';
  }

  val = val.trim();

  if (RegExp('(-)+').hasMatch(val)) {
    return '$label should not contain a sign.';
  }
  if (RegExp('[^eE0-9\s,.]').hasMatch(val)) {
    return 'Only numbers are allowed.';
  }

  return null;
}

String validateLoginEmail(String email) {
  if (email == null || email.trim() == '') {
    return 'Email is required';
  }
  if (validateEmail(email) != null) {
    return 'Enter a valid email address';
  }

  return null;
}

String validateLoginPassword(String password) {
  if (password == null || password == '') {
    return 'Password is required';
  }

  return null;
}

String validateLoginUsername(String username) {
  if (username == null || username.trim() == '') {
    return 'Username is required';
  }
  if (validateUsername(username) != null) {
    return 'Enter a valid username';
  }

  return null;
}

String validateRequired(String value, String name, {int minLength}) {
  if (value == null || value.trim() == '') {
    return '$name is required';
  }

  if (minLength != null && value.length < minLength) {
    return '$name requires at least $minLength characters';
  }

  return null;
}

String confirmPassword(String password, String value, String name) {
  if (validateRequired(value, name) != null) {
    return validateRequired(value, name);
  }
  if (password != value) {
    return '$name does not match';
  }

  return null;
}

// Formats money value

String formatMoney(dynamic value, {int precision = 2}) {
  assert(precision >= 0 && precision <= 20);

  double d;
  try {
    if (value is num) {
      d = value.toDouble();
    } else {
      d = double.parse(value);
    }
  } catch (_, __) {
    return value;
  }
  var money = (d).toStringAsFixed(precision);

  money = money.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
  return money;
}

String formatNairaString(value, {int precision = 2}) {
  return '${String.fromCharCodes(Runes('\u20A6'))}${formatMoney(value, precision: precision)}';
}

// Formats money value to Naira
Widget formatNaira(
  value,
  TextStyle style, {
  int precision = 2,
  TextStyle symbolStyle,
  MainAxisAlignment alignment = MainAxisAlignment.end,
  bool smallMantissa = false,
}) {
  var _value = formatMoney(value, precision: precision);
  var _result = _value;
  var _mantissa;
  if (_value != null &&
      _value.contains('.') &&
      smallMantissa == true &&
      precision > 0) {
    _result = _value.split('.')[0];
    _mantissa = _value.split('.')[1];
  }
  return Row(
    crossAxisAlignment: CrossAxisAlignment.baseline,
    textBaseline: TextBaseline.alphabetic,
    mainAxisAlignment: alignment,
    children: <Widget>[
      Text(
        String.fromCharCodes(Runes('\u20A6')),
        style: symbolStyle is TextStyle ? symbolStyle : style,
      ),
      Text('$_result', style: style),
      if (_mantissa != null)
        Text(
          '.$_mantissa',
          style: symbolStyle is TextStyle ? symbolStyle : style,
        ),
    ],
  );
}

T minNum<T extends num>(List<T> items) {
  T _min = items[0];
  items.forEach((T item) {
    _min = min(_min, item);
  });
  return _min;
}

T maxNum<T extends num>(List<T> items) {
  T _max = items[0];
  items.forEach((T item) {
    _max = max<T>(_max, item);
  });
  return _max;
}

bool isNotEmpty(String value) {
  return value != null && value.isNotEmpty;
}

bool isEmpty(String value) {
  return value != null && value.isEmpty;
}

Function() createOverlayEntry({
  @required BuildContext context,
  @required Widget child,
  bool backIntercept = false,
  Function willPopCallback,
}) {
  final overlayState = Overlay.of(context);
  ModalRoute _route;

  OverlayEntry overlayEntry = new OverlayEntry(builder: (context) {
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.bodyText2,
      child: child,
    );
  });
  overlayState.insert(overlayEntry);

  Future<bool> backClose() {
    willPopCallback();
    return Future.value(false);
  }

  void close() {
    overlayEntry?.remove();
    _route?.removeScopedWillPopCallback(backClose);
  }

  if (willPopCallback != null) {
    _route = ModalRoute.of(context);

    _route.addScopedWillPopCallback(backClose);
  }

  return close;
}

class MaskedTextController extends TextEditingController {
  MaskedTextController({String text, this.mask, Map<String, RegExp> translator})
      : super(text: text) {
    this.translator = translator ?? MaskedTextController.getDefaultTranslator();

    addListener(() {
      final String previous = _lastUpdatedText;
      if (this.beforeChange(previous, this.text)) {
        updateText(this.text);
        this.afterChange(previous, this.text);
      } else {
        updateText(_lastUpdatedText);
      }
    });

    updateText(this.text);
  }

  String mask;

  Map<String, RegExp> translator;

  Function afterChange = (String previous, String next) {};
  Function beforeChange = (String previous, String next) {
    return true;
  };

  String _lastUpdatedText = '';

  void updateText(String text) {
    if (text != null) {
      this.text = _applyMask(mask, text);
    } else {
      this.text = '';
    }

    _lastUpdatedText = this.text;
  }

  void updateMask(String mask, {bool moveCursorToEnd = true}) {
    this.mask = mask;
    updateText(text);

    if (moveCursorToEnd) {
      this.moveCursorToEnd();
    }
  }

  void moveCursorToEnd() {
    final String text = _lastUpdatedText;
    selection =
        TextSelection.fromPosition(TextPosition(offset: (text ?? '').length));
  }

  @override
  set text(String newText) {
    if (super.text != newText) {
      super.text = newText;
      moveCursorToEnd();
    }
  }

  static Map<String, RegExp> getDefaultTranslator() {
    return <String, RegExp>{
      'A': RegExp(r'[A-Za-z]'),
      '0': RegExp(r'[0-9]'),
      '@': RegExp(r'[A-Za-z0-9]'),
      '*': RegExp(r'.*')
    };
  }

  String _applyMask(String mask, String value) {
    String result = '';

    int maskCharIndex = 0;
    int valueCharIndex = 0;

    while (true) {
      // if mask is ended, break.
      if (maskCharIndex == mask.length) {
        break;
      }

      // if value is ended, break.
      if (valueCharIndex == value.length) {
        break;
      }

      final String maskChar = mask[maskCharIndex];
      final String valueChar = value[valueCharIndex];

      // value equals mask, just set
      if (maskChar == valueChar) {
        result += maskChar;
        valueCharIndex += 1;
        maskCharIndex += 1;
        continue;
      }

      // apply translator if match
      if (translator.containsKey(maskChar)) {
        if (translator[maskChar].hasMatch(valueChar)) {
          result += valueChar;
          maskCharIndex += 1;
        }

        valueCharIndex += 1;
        continue;
      }

      // not masked value, fixed char on mask
      result += maskChar;
      maskCharIndex += 1;
      continue;
    }

    return result;
  }
}
