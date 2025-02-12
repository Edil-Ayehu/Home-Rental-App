import 'package:flutter/material.dart';
import '../models/property_model.dart';

class PropertyController extends ChangeNotifier {
  List<Property> getPropertiesByOwnerId(String ownerId) {
    return Property.dummyProperties.where((p) => p.ownerId == ownerId).toList();
  }
}
