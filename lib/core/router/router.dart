import 'package:go_router/go_router.dart';
import 'package:home_rental_app/main_layout.dart';
import 'package:home_rental_app/models/message.dart';
import 'package:home_rental_app/models/property_model.dart';
import 'package:home_rental_app/views/auth/forgot_password_screen.dart';
import 'package:home_rental_app/views/auth/login_screen.dart';
import 'package:home_rental_app/views/auth/register_screen.dart';
import 'package:home_rental_app/views/booking/booking_form_screen.dart';
import 'package:home_rental_app/views/booking/bookings_screen.dart';
import 'package:home_rental_app/views/chat/chat_detail_screen.dart';
import 'package:home_rental_app/views/chat/messages_screen.dart';
import 'package:home_rental_app/views/favorites/favorites_screen.dart';
import 'package:home_rental_app/views/home/home_screen.dart';
import 'package:home_rental_app/views/home/property_details_screen.dart';
import 'package:home_rental_app/views/home/search_screen.dart';
import 'package:home_rental_app/views/land_lord/add_property_screen.dart';
import 'package:home_rental_app/views/land_lord/landlord_dashboard_screen.dart';
import 'package:home_rental_app/views/notifications/notifications_screen.dart';
import 'package:home_rental_app/views/onboarding/onboarding_screen.dart';
import 'package:home_rental_app/views/profile/add_payment_method_screen.dart';
import 'package:home_rental_app/views/profile/help_center_screen.dart';
import 'package:home_rental_app/views/profile/payment_methods_screen.dart';
import 'package:home_rental_app/views/profile/personal_information_screen.dart';
import 'package:home_rental_app/views/profile/privacy_policy_screen.dart';
import 'package:home_rental_app/views/profile/profile_screen.dart';
import 'package:home_rental_app/views/splash/splash_screen.dart';

final router = GoRouter(
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
            GoRoute(
              path: 'book',
              builder: (context, state) {
                final property = state.extra as Property;
                return BookingFormScreen(property: property);
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
          path: '/notifications',
          builder: (context, state) => const NotificationsScreen(),
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
          routes: [
            GoRoute(
              path: 'personal-information',
              builder: (context, state) => const PersonalInformationScreen(),
            ),
            GoRoute(
              path: 'payment-methods',
              builder: (context, state) => const PaymentMethodsScreen(),
            ),
            GoRoute(
              path: 'payment-methods/add',
              builder: (context, state) => const AddPaymentMethodScreen(),
            ),
            GoRoute(
              path: 'help-center',
              builder: (context, state) => const HelpCenterScreen(),
            ),
            GoRoute(
              path: 'privacy-policy',
              builder: (context, state) => const PrivacyPolicyScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/landlord/dashboard',
      builder: (context, state) => const LandlordDashboardScreen(),
    ),
    GoRoute(
      path: '/landlord/add-property',
      builder: (context, state) => const AddPropertyScreen(),
    ),
    GoRoute(
      path: '/landlord/edit-property/:id',
      builder: (context, state) {
        final property = state.extra as Property;
        return AddPropertyScreen(property: property);
      },
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
