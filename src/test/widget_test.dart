

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:src/features/auth/presentation/pages/login_page.dart';
import 'package:src/features/auth/presentation/pages/signup_page.dart';
import 'package:src/features/auth/presentation/viewmodels/user_controller.dart';

import 'mockUserController.dart';

void main() {
  setUp(() {
    Get.reset();
    Get.testMode = true;
    Get.put<UserController>(FakeUserController());
  });

  Widget createWidgetLogin() {
    return const GetMaterialApp(
      home: LoginPage(key: Key('LoginPage'), showBackground: false),
    );
  }

  Widget createWidgetSignup() {
    return const GetMaterialApp(
      home: SignupPage(key: Key('SignupPage'), showBackground: false),
    );
  }

  testWidgets('Widget login validación @ email', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetLogin());

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

  testWidgets('Widget login validación @ email', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetLogin());

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

  testWidgets('Widget login validación campo vacio email', (tester) async {
    await tester.pumpWidget(createWidgetLogin());

    await tester.enterText(
      find.byKey(const Key('TextFormFieldLoginEmail')),
      '',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldLoginPassword')),
      '123456',
    );

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pumpAndSettle();

    expect(find.text('Enter email'), findsOneWidget);
  });

  testWidgets('Widget login validación número de caracteres password', (
    tester,
  ) async {
    await tester.pumpWidget(createWidgetLogin());

    await tester.enterText(
      find.byKey(const Key('TextFormFieldLoginEmail')),
      'a@a.com',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldLoginPassword')),
      '123',
    );

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pumpAndSettle();

    expect(
      find.text('Password should have at least 6 characters'),
      findsOneWidget,
    );
  });

  testWidgets('Widget login validación campo vacio password', (tester) async {
    await tester.pumpWidget(createWidgetLogin());

    await tester.enterText(
      find.byKey(const Key('TextFormFieldLoginEmail')),
      'a@a.com',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldLoginPassword')),
      '',
    );

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));
    await tester.pumpAndSettle();

    expect(find.text('Enter password'), findsOneWidget);
  });

  testWidgets('Widget login autenticación exitosa', (tester) async {
    await tester.pumpWidget(createWidgetLogin());

    final controller = Get.find<UserController>();

    await tester.enterText(
      find.byKey(const Key('TextFormFieldLoginEmail')),
      'a@a.com',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldLoginPassword')),
      '123456',
    );

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));

    await tester.pumpAndSettle();

    expect(controller.isLogged, true);
  });

  testWidgets('Widget login autenticación no exitosa', (tester) async {
    await tester.pumpWidget(createWidgetLogin());

    final controller = Get.find<UserController>();

    await tester.enterText(
      find.byKey(const Key('TextFormFieldLoginEmail')),
      'b@a.com',
    );

    await tester.enterText(
      find.byKey(const Key('TextFormFieldLoginPassword')),
      '123456',
    );

    await tester.tap(find.byKey(const Key('ButtonLoginSubmit')));

    await tester.pumpAndSettle();

    expect(controller.isLogged, false);
  });

  //signup

  testWidgets('Widget signup validación nombre vacío', (tester) async {
    await tester.pumpWidget(createWidgetSignup());

    await tester.enterText(
      find.byKey(const Key('TextFormFieldSignupName')),
      '',
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

    expect(find.byKey(const Key('SignupPage')), findsOneWidget);
  });
}
