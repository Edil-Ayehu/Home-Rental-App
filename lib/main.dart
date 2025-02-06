import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_app/core/services/storage_service.dart';
import 'package:home_rental_app/main_layout.dart';
import 'package:home_rental_app/models/message.dart';
import 'package:home_rental_app/models/property_model.dart';
import 'package:home_rental_app/views/auth/forgot_password_screen.dart';
import 'package:home_rental_app/views/auth/login_screen.dart';
import 'package:home_rental_app/views/auth/register_screen.dart';
import 'package:home_rental_app/views/booking/bookings_screen.dart';
import 'package:home_rental_app/views/chat/chat_detail_screen.dart';
import 'package:home_rental_app/views/chat/messages_screen.dart';
import 'package:home_rental_app/views/favorites/favorites_screen.dart';
import 'package:home_rental_app/views/home/home_screen.dart';
import 'package:home_rental_app/views/home/property_details_screen.dart';
import 'package:home_rental_app/views/home/search_screen.dart';
import 'package:home_rental_app/views/onboarding/onboarding_screen.dart';
import 'package:home_rental_app/views/profile/profile_screen.dart';
import 'core/constants/color_constants.dart';
import 'views/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  // Initialize Firebase here
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      builder: (context, state, child) => MainLayout(
        child: child,
        location: state.uri.toString(),
      ),
      routes: [
        GoRoute(
          path: '/home',
          builder: (context, state) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'property/:id',
              builder: (context, state) {
                final property = state.extra as Property;
                return PropertyDetailsScreen(
                  propertyId: state.pathParameters['id']!,
                  property: property,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) => const FavoritesScreen(),
        ),
        GoRoute(
          path: '/bookings',
          builder: (context, state) => const BookingsScreen(),
        ),
GoRoute(
  path: '/messages',
  builder: (context, state) => const MessagesScreen(),
  routes: [
    GoRoute(
      path: 'chat',
      builder: (context, state) {
        final message = state.extra as Message;
        return ChatDetailScreen(message: message);
      },
    ),
  ],
),
        GoRoute(
          path: '/profile',
          builder: (context, state) => const ProfileScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: 'forgot-password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/search',
      name: 'search',
      builder: (context, state) => const SearchScreen(),
    ),
  ],
);

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
          routerConfig: _router,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              background: AppColors.background,
            ),
            textTheme: GoogleFonts.poppinsTextTheme(
              Theme.of(context).textTheme,
            ),
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.surface,
              elevation: 0,
              centerTitle: true,
              iconTheme: IconThemeData(color: AppColors.secondary),
              titleTextStyle: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
    );
  }
}
