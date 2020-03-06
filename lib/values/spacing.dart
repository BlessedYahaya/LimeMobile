import 'package:flutter/material.dart';

class VSpace {
  static const Widget xs = const SizedBox(height: 5);
  static const Widget sm = const SizedBox(height: 8);
  static const Widget md = const SizedBox(height: 16);
  static const Widget lg = const SizedBox(height: 24);
  static const Widget xl = const SizedBox(height: 32);
  static const Widget xxl = const SizedBox(height: 48);
}

class VFlexSpace {
  static final Widget xs = ConstrainedBox(
    constraints: BoxConstraints(minHeight: 3, maxHeight: 5),
  );
  static final Widget sm = ConstrainedBox(
    constraints: BoxConstraints(minHeight: 5, maxHeight: 8),
  );
  static final Widget md = ConstrainedBox(
    constraints: BoxConstraints(minHeight: 8, maxHeight: 16),
  );
  static final Widget lg = ConstrainedBox(
    constraints: BoxConstraints(minHeight: 16, maxHeight: 24),
  );
  static final Widget xl = ConstrainedBox(
    constraints: BoxConstraints(minHeight: 24, maxHeight: 32),
  );
  static final Widget xxl = ConstrainedBox(
    constraints: BoxConstraints(minHeight: 32, maxHeight: 48),
  );
}

class HSpace {
  static const Widget xs = const SizedBox(width: 5);
  static const Widget sm = const SizedBox(width: 8);
  static const Widget md = const SizedBox(width: 16);
  static const Widget lg = const SizedBox(width: 24);
  static const Widget xl = const SizedBox(width: 32);
  static const Widget xxl = const SizedBox(width: 48);
}

class HFlexSpace {
  static final Widget xs = ConstrainedBox(
    constraints: BoxConstraints(minWidth: 3, maxWidth: 5),
  );
  static final Widget sm = ConstrainedBox(
    constraints: BoxConstraints(minWidth: 5, maxWidth: 8),
  );
  static final Widget md = ConstrainedBox(
    constraints: BoxConstraints(minWidth: 8, maxWidth: 16),
  );
  static final Widget lg = ConstrainedBox(
    constraints: BoxConstraints(minWidth: 16, maxWidth: 24),
  );
  static final Widget xl = ConstrainedBox(
    constraints: BoxConstraints(minWidth: 24, maxWidth: 32),
  );
  static final Widget xxl = ConstrainedBox(
    constraints: BoxConstraints(minWidth: 32, maxWidth: 48),
  );
}
