import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:loggy/loggy.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:src/core/i_local_preferences.dart';
import 'package:src/core/local_preferences_secured.dart';
import 'package:src/core/local_preferences_shared.dart';
import 'package:src/core/refresh_client.dart';
import 'package:src/core/navigation/app_pages.dart'; 
import 'package:src/features/auth/data/datasources/remote/authentication_source_service_roble.dart';
import 'package:src/features/auth/data/datasources/remote/i_authentication_source.dart';
import 'package:src/features/auth/data/repository/auth_repository.dart';
import 'package:src/features/auth/domain/repositories/i_auth_repository.dart';
import 'package:src/features/auth/presentation/viewmodels/user_controller.dart';

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
      initialRoute: AppPages.initial,        getPages: AppPages.routes,       
    );
  }
}