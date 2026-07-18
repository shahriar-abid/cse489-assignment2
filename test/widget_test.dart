import 'package:flutter_test/flutter_test.dart';
import 'package:assignment2/main.dart';
import 'package:assignment2/core/constants/app_strings.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AssignmentApp());

    // Verify that the app title is present.
    expect(find.text(AppStrings.appTitle), findsOneWidget);
  });
}
