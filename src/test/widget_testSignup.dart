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
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:src/features/auth/presentation/pages/signup_page.dart';
import 'package:src/features/auth/presentation/viewmodels/user_controller.dart';

import 'mockUserController.dart';

void main() {
  setUp(() {
    Get.reset();
    Get.testMode = true;
    Get.put<UserController>(FakeUserController());
  });

  Widget createWidgetSignup() {
    return const GetMaterialApp(
      home: SignupPage(key: Key('SignupPage'), showBackground: false),
    );
  }

  testWidgets('Widget signup validación nombre vacío', (tester) async {
    await tester.pumpWidget(createWidgetSignup());

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupEmail')),
      'a@a.com',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupPassword')),
      '12345678',
    );

    await tester.tap(find.byKey(const Key('ButtonSignupSubmit')));
    await tester.pumpAndSettle();

    expect(find.text('Enter name'), findsOneWidget);
  });

  testWidgets('Widget signup validación email', (tester) async {
    await tester.pumpWidget(createWidgetSignup());

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupName')),
      'Sebas',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupEmail')),
      'a.com',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupPassword')),
      '12345678',
    );

    await tester.tap(find.byKey(const Key('ButtonSignupSubmit')));
    await tester.pumpAndSettle();

    expect(find.text('Enter valid email address'), findsOneWidget);
  });

  testWidgets('Widget signup validación password corto', (tester) async {
    await tester.pumpWidget(createWidgetSignup());

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupName')),
      'Sebas',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupEmail')),
      'a@a.com',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupPassword')),
      '123',
    );

    await tester.tap(find.byKey(const Key('ButtonSignupSubmit')));
    await tester.pumpAndSettle();

    expect(
      find.text('Password should have at least 8 characters'),
      findsOneWidget,
    );
  });

  testWidgets('Widget signup exitoso', (tester) async {
    await tester.pumpWidget(createWidgetSignup());

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupName')),
      'Sebas',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupEmail')),
      'a@a.com',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupPassword')),
      '12345678',
    );

    await tester.tap(find.byKey(const Key('ButtonSignupSubmit')));

    await tester.pump();
    await tester.pumpAndSettle();

    // No hay navegación, solo verificar que no crashea
    expect(find.byKey(const Key('SignupPage')), findsOneWidget);
  });

  testWidgets('Widget signup no exitoso', (tester) async {
    await tester.pumpWidget(createWidgetSignup());

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupName')),
      'Sebas',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupEmail')),
      'b@a.com',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupPassword')),
      '12345678',
    );

    await tester.tap(find.byKey(const Key('ButtonSignupSubmit')));

    await tester.pumpAndSettle();

    // Se mantiene en la misma pantalla
    expect(find.byKey(const Key('SignupPage')), findsOneWidget);
  });
}
