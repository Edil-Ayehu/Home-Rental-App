import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_app/views/booking/bookings_screen.dart';
import 'package:home_rental_app/views/chat/messages_screen.dart';
import 'package:home_rental_app/views/favorites/favorites_screen.dart';
import 'package:home_rental_app/views/home/home_screen.dart';
import 'package:home_rental_app/views/profile/profile_screen.dart';
import '../../widgets/common/bottom_navigation.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const FavoritesScreen(),
    const BookingsScreen(),
    const MessagesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          switch (index) {
            case 0:
              context.go('/home');
              break;
            case 1:
              context.go('/home/favorites');
              break;
            case 2:
              context.go('/home/bookings');
              break;
            case 3:
              context.go('/home/messages');
              break;
            case 4:
              context.go('/home/profile');
              break;
          }
        },
      ),
    );
  }
}
