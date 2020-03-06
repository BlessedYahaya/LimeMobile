import 'package:flutter_test/flutter_test.dart';
import 'package:lime_mobile_app/main.dart';

void main() {
  testWidgets('Empty test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(App());
  });
}
