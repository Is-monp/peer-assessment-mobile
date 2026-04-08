import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:src/central.dart';
import 'package:src/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('App carga y muestra la HomePage', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // Verifica que la pantalla inicial carga
    expect(find.text('Evaluo'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);

    Get.deleteAll();
  });
}