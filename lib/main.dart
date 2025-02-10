import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:home_rental_app/core/router/router.dart';
import 'package:home_rental_app/core/services/storage_service.dart';
import 'package:home_rental_app/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  // Initialize Firebase here
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          title: 'Home Rental App',
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          theme: AppTheme.lightTheme(context),
        );
      },
    );
  }
}
