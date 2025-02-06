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
void didChangeDependencies() {
  super.didChangeDependencies();
  final router = GoRouter.of(context);
  final String currentLocation = router.routeInformationProvider.value.location;
  _updateIndexFromLocation(currentLocation);
}

  void _updateIndexFromLocation(String location) {
    setState(() {
      if (location.startsWith('/home/favorites')) {
        _currentIndex = 1;
      } else if (location.startsWith('/home/bookings')) {
        _currentIndex = 2;
      } else if (location.startsWith('/home/messages')) {
        _currentIndex = 3;
      } else if (location.startsWith('/home/profile')) {
        _currentIndex = 4;
      } else {
        _currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigation(
        currentIndex: _currentIndex,
        onTap: (index) {
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
