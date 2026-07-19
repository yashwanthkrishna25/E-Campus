import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:e_campus/main.dart';

void main() {
  testWidgets('E-Campus app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ECampusApp());
    expect(find.byType(ECampusApp), findsOneWidget);
    
    // Fast forward past the splash delay so the timer doesn't leak
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();
  });
}
