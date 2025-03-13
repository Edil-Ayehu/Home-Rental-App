import 'package:flutter/material.dart';

class NotificationItem {
  final String id;
  final IconData icon;
  final String title;
  final String description;
  final String time;
  final bool isUnread;
  final dynamic data; // This can hold related data like Property or Message objects

  NotificationItem({
    required this.id,
    required this.icon,
    required this.title,
    required this.description,
    required this.time,
    required this.isUnread,
    this.data,
  });
}