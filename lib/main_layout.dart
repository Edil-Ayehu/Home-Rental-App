import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_rental_app/views/booking/bookings_screen.dart';
import 'package:home_rental_app/views/chat/messages_screen.dart';
import 'package:home_rental_app/views/favorites/favorites_screen.dart';
import 'package:home_rental_app/views/home/home_screen.dart';
import 'package:home_rental_app/views/profile/profile_screen.dart';
import '../../widgets/common/bottom_navigation.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  
  const MainLayout({
    super.key,
    required this.child,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          switch (index) {
            case 0:
              context.pushReplacement('/home');
              break;
            case 1:
              context.pushReplacement('/home/favorites');
              break;
            case 2:
              context.pushReplacement('/home/bookings');
              break;
            case 3:
              context.pushReplacement('/home/messages');
              break;
            case 4:
              context.pushReplacement('/home/profile');
              break;
          }
        },
      ),
    );
  }
}
