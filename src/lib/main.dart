import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loggy/loggy.dart';
import 'package:src/core/i_local_preferences.dart';
import 'package:src/core/local_preferences_secured.dart';
import 'package:src/core/local_preferences_shared.dart';
import 'package:src/core/refresh_client.dart';
import 'package:src/features/auth/data/datasources/remote/authentication_source_service_roble.dart';
import 'package:src/features/auth/data/datasources/remote/i_authentication_source.dart';
import 'package:src/features/auth/data/repository/auth_repository.dart';
import 'package:src/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:src/features/auth/presentation/viewmodels/user_controller.dart';
import 'package:src/features/auth/presentation/pages/signup_page.dart';
import 'package:src/features/Splash-Screen/presentation/pages/home_page.dart';
import 'package:src/features/auth/presentation/pages/login_page.dart';
import 'package:src/features/home-student/presentation/pages/home_student_page.dart';
import 'package:src/features/home-student/presentation/state_management/home_student_binding.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'features/home-profesor/presentation/pages/home_professor_page.dart';
import 'features/home-profesor/presentation/state_management/home_professor_binding.dart';
import 'features/tap-on-course/presentation/pages/tap_course_page.dart';
import 'features/tap-on-course/presentation/state_management/tap_course_binding.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  Loggy.initLoggy(logPrinter: const PrettyPrinter(showColors: true));

  if (!kIsWeb) {
    Get.put<ILocalPreferences>(LocalPreferencesSecured());
  } else {
    Get.put<ILocalPreferences>(LocalPreferencesShared());
  }

  Get.lazyPut<IAuthenticationSource>(
    () => AuthenticationSourceServiceRoble(),
    fenix: true,
  );

  Get.put<http.Client>(
    RefreshClient(http.Client(), Get.find<IAuthenticationSource>()),
    tag: 'apiClient',
    permanent: true,
  );

  Get.put<IAuthRepository>(AuthRepository(Get.find()));
  // register UserController as a permanent global dependency so it persists across all routes and can be retrieved with Get.find<UserController>()
  Get.put(UserController(Get.find()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Evaluo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/signin', page: () => const SignupPage()),
        GetPage(
          name: '/home-student',
          page: () => const HomeStudentPage(),
          binding: HomeStudentBinding(),
        ),
        GetPage(
          name: '/home-professor',
          page: () => const HomeProfessorPage(),
          binding: HomeProfessorBinding(),
        ),
        GetPage(
          name: '/course-detail',
          page: () => const TapCoursePage(),
          binding: TapCourseBinding(),
        ),
      ],
    );
  }
}
