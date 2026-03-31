// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:src/features/auth/presentation/pages/login_page.dart';
import 'package:src/features/auth/presentation/viewmodels/user_controller.dart';

import 'package:src/main.dart';

import 'mockUserController.dart';

void main() {
  setUp(() {
    Get.reset();
    Get.put<UserController>(FakeUserController());
  });

  Widget createWidget() {
    return const GetMaterialApp(
      home: LoginPage(key: Key('LoginPage'), showBackground: false),
    );
  }

  testWidgets('Widget login validación @ email', (WidgetTester tester) async {
    await tester.pumpWidget(createWidget());

    expect(find.byKey(const Key('LoginPage')), findsOneWidget);

    await tester.enterText(
      find.byKey(const Key('TextFormFieldLoginEmail')),
      'a.com',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldLoginPassword')),
      '123456',
    );

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pumpAndSettle();

    expect(find.text('Enter valid email address'), findsOneWidget);
  });
}
