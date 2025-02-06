import 'package:flutter/material.dart';
import '../../../../core/constants/color_constants.dart';

class PageLayout extends StatelessWidget {
  final String title;
  final Widget body;
  final List<Widget>? actions;

  const PageLayout({
    super.key,
    required this.title,
    required this.body,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(title),
        actions: actions,
      ),
      body: SafeArea(child: body),
    );
  }
}
