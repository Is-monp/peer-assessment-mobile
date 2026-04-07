import 'dart:convert';
import 'package:src/features/auth/domain/models/authentication_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart'; 
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:src/core/i_local_preferences.dart';
import 'package:src/features/auth/data/datasources/remote/i_authentication_source.dart';
import 'package:src/features/auth/data/repository/auth_repository.dart';
import 'package:src/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:src/features/auth/presentation/viewmodels/user_controller.dart';
import 'package:src/features/home-professor/data/datasources/home_professor_datasource.dart';
import 'package:src/features/home-professor/data/datasources/remote_home_professor_datasource.dart';
import 'package:src/features/home-professor/data/repositories/home_professor_repository_impl.dart';
import 'package:src/features/home-professor/domain/repositories/home_professor_repository.dart';
import 'package:src/features/home-professor/domain/usecases/get_assigned_courses.dart';
import 'package:src/features/home-professor/presentation/state_management/home_professor_controller.dart';
import 'package:src/features/home-professor/presentation/pages/home_professor_page.dart';

class _IsAUri extends Matcher {
  const _IsAUri();
  @override
  bool matches(dynamic item, Map matchState) => item is Uri;
  @override
  Description describe(Description description) => description.add('is a Uri');
}
const Matcher isAUri = _IsAUri();


class MockHttpClient extends Mock implements http.Client {
  @override
  Future<http.Response> get(Uri? url, {Map<String, String>? headers}) =>
      super.noSuchMethod(
        Invocation.method(#get, [url], {#headers: headers}),
        returnValue: Future.value(http.Response('[]', 200)),
        returnValueForMissingStub: Future.value(http.Response('[]', 200)),
      );
}


class FakeLocalPreferences implements ILocalPreferences {
  final Map<String, String> _storage = {
    'token': 'fake_token',
    'userId': 'prof-1',
    'userName': 'Josh Doe',
  };
  @override Future<String?> getString(String key) async => _storage[key];
  @override Future<void> setString(String key, String value) async => _storage[key] = value;
  @override Future<void> remove(String key) async => _storage.remove(key);
  @override Future<void> clear() async => _storage.clear();
  @override Future<bool?> getBool(String key) async => null;
  @override Future<void> setBool(String key, bool value) async {}
  @override Future<double?> getDouble(String key) async => null;
  @override Future<void> setDouble(String key, double value) async {}
  @override Future<int?> getInt(String key) async => null;
  @override Future<void> setInt(String key, int value) async {}
  @override Future<List<String>?> getStringList(String key) async => null;
  @override Future<void> setStringList(String key, List<String> value) async {}
}


class FakeAuthenticationSource implements IAuthenticationSource {
  @override
  Future<void> login(String email, String password) async {}
  @override
  Future<void> signUp(String email, String password, String name, bool direct) async {}
  @override
  Future<bool> logOut() async => true;
  @override
  Future<bool> validate(String email, String validationCode) async => true;
  @override
  Future<bool> refreshToken() async => true;
  @override
  Future<bool> forgotPassword(String email) async => true;
  @override
  Future<bool> resetPassword(String email, String newPassword, String validationCode) async => true;
  @override
  Future<bool> verifyToken() async => true;
  @override
  Future<AuthenticationUser> getLoggedUser() async =>
      AuthenticationUser(id: 'prof-1', email: 'prof@test.com', name: 'Josh Doe', student: false);
  @override
  Future<List<AuthenticationUser>> getUsers() async => [];
}


void main() {

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockHttpClient mockHttpClient;

  setUpAll(() async {
    await dotenv.load(fileName: '.env');
  });

  setUp(() {
    mockHttpClient = MockHttpClient();

    // Dependencias reales, solo el http.Client es mock
    Get.put<ILocalPreferences>(FakeLocalPreferences());
    Get.put<http.Client>(mockHttpClient, tag: 'apiClient', permanent: true);
    Get.put<IAuthenticationSource>(FakeAuthenticationSource());
    Get.put<IAuthRepository>(AuthRepository(Get.find()));
    Get.put(UserController(Get.find()));

    // DataSource REAL (RemoteHomeProfessorDataSource)
    Get.lazyPut<HomeProfessorDataSource>(
      () => RemoteHomeProfessorDataSource(
        Get.find<http.Client>(tag: 'apiClient'),
      ),
    );

    // Repositorio REAL (HomeProfessorRepositoryImpl)
    Get.lazyPut<HomeProfessorRepository>(
      () => HomeProfessorRepositoryImpl(Get.find()),
    );

    // Use case REAL
    Get.lazyPut(() => GetAssignedCourses(Get.find()));

    // Controlador REAL
    Get.lazyPut(() => HomeProfessorController(
      getAssignedCourses: Get.find(),
    ));
  });

  tearDown(() => Get.reset());

  group('HomeProfessorPage — Integration Test con HTTP mock', () {
    testWidgets(
      'Muestra los cursos del profesor desde respuesta HTTP simulada',
      (WidgetTester tester) async {

        
        final coursesJson = jsonEncode([
          {
            '_id': 'course-1',
            'code': 'CS101',
            'name': 'Software Design',
            'period': '2024-10',
            'studentsCount': 30,
            'activeEvaluations': 2,
          },
          {
            '_id': 'course-2',
            'code': 'CS201',
            'name': 'Data Structures',
            'period': '2024-10',
            'studentsCount': 25,
            'activeEvaluations': 1,
          },
        ]);

       
        when(mockHttpClient.get(
          argThat(isAUri),
          headers: anyNamed('headers'),
        )).thenAnswer((_) async => http.Response(coursesJson, 200));

     
        await tester.pumpWidget(const GetMaterialApp(
          home: HomeProfessorPage(),
        ));

     
        await tester.pumpAndSettle();

        expect(find.text('Software Design'), findsOneWidget);
        expect(find.text('Data Structures'), findsOneWidget);
        expect(find.text('2 total'), findsOneWidget);

        verify(mockHttpClient.get(
          argThat(isAUri),
          headers: anyNamed('headers'),
        )).called(1);
      },
    );
  });
}