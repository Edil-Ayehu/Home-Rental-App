import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../models/property_model.dart';


class PropertyMap extends StatelessWidget {
  final Property property;
  final double height;

  const PropertyMap({
    super.key,
    required this.property,
    this.height = 200,
  });

  @override
  Widget build(BuildContext context) {
    final propertyLocation = LatLng(property.latitude, property.longitude);

    return SizedBox(
      height: height.h,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: propertyLocation,
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: MarkerId(property.id),
            position: propertyLocation,
            infoWindow: InfoWindow(title: property.title),
          ),
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        mapToolbarEnabled: true,
      ),
    );
  }
}
