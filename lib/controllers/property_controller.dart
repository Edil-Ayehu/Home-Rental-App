import 'dart:io';
import 'package:flutter/material.dart';
import '../models/property_model.dart';
import '../models/rating_model.dart';

class PropertyController extends ChangeNotifier {
  List<Property> getPropertiesByOwnerId(String ownerId) {
    return Property.dummyProperties.where((p) => p.ownerId == ownerId).toList();
  }


  Future<String> uploadImage(File image) async {
    // TODO: Implement actual image upload to your backend/storage
    // For now, we'll simulate an upload
    await Future.delayed(const Duration(seconds: 1));
    return 'https://example.com/uploaded-image.jpg';
  }

  Future<Property> addProperty({
    required String title,
    required String location,
    required double price,
    required File thumbnailImage,
    required List<File> additionalImages,
    required String ownerId,
    required double latitude,
    required double longitude,
    required String type,
  }) async {
    // Upload thumbnail
    final thumbnailUrl = await uploadImage(thumbnailImage);
    
    // Upload additional images
    final imageUrls = await Future.wait(
      additionalImages.map((image) => uploadImage(image))
    );

    // Create new property
    final newProperty = Property(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      ownerId: ownerId,
      title: title,
      location: location,
      price: price,
      imageUrl: thumbnailUrl,
      images: [thumbnailUrl, ...imageUrls],
      isAvailable: true,
      latitude: latitude,
      longitude: longitude,
      type: type,
    );

    // TODO: Add to backend
    Property.dummyProperties.add(newProperty);
    notifyListeners();
    
    return newProperty;
  }

  List<Rating> getPropertyReviews(String propertyId) {
    return Rating.dummyRatings
        .where((rating) => rating.propertyId == propertyId)
        .toList();
  }

  double getPropertyAverageRating(String propertyId) {
    final reviews = getPropertyReviews(propertyId);
    if (reviews.isEmpty) return 0.0;
    
    final totalRating = reviews.fold(0.0, (sum, review) => sum + review.rating);
    return totalRating / reviews.length;
  }
}
