import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:lawconnect_gh/app/app.dart';

void main() {
  testWidgets('LawConnect app smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const ProviderScope(
        child: LawConnectApp(),
      ),
    );

    // Verify that our app loads with splash screen
    expect(find.text('LawConnect GH'), findsOneWidget);
  });
}