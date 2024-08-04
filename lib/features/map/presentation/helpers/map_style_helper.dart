import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../gen/my_assets.dart';

abstract class MapStyleHelper {
  static Future<String> getMapStyle({required bool isDarkMode}) async {
    return rootBundle.loadString(
      isDarkMode
          ? MyAssets.ASSETS_MAP_STYLES_DARK_MAP_JSON
          : MyAssets.ASSETS_MAP_STYLES_LIGHT_MAP_JSON,
    );
  }

  static Future<Uint8List?> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))?.buffer.asUint8List();
  }

  static Future<BitmapDescriptor> getMyLocationMarkerIcon() async {
    final markerIcon = await getBytesFromAsset(MyAssets.ASSETS_ICONS_DELIVERY_ICON_PNG, 200);
    if (markerIcon != null) {
      return BitmapDescriptor.fromBytes(markerIcon);
    }

    return BitmapDescriptor.fromAssetImage(
      ImageConfiguration.empty,
      MyAssets.ASSETS_ICONS_DELIVERY_ICON_PNG,
    );
  }

  static Marker getMyLocationMarker({
    required LatLng position,
    required double rotation,
    required BitmapDescriptor markerIcon,
  }) {
    return Marker(
      markerId: const MarkerId('currentLocation'),
      position: position,
      rotation: rotation,
      zIndex: 2,
      flat: true,
      infoWindow: const InfoWindow(title: 'My current location'),
      anchor: const Offset(0.5, 0.5),
      icon: markerIcon,
    );
  }

  static Circle getMyLocationCircle({
    required LatLng position,
    required double radius,
  }) {
    return Circle(
      circleId: const CircleId('currentLocationCircle'),
      center: position,
      radius: radius,
      zIndex: 1,
      strokeWidth: 2,
      strokeColor: Colors.blue,
      fillColor: Colors.blue.withAlpha(70),
    );
  }

  static Marker getSelectedPlaceMarker({
    required LatLng position,
    required String description,
    required void Function(LatLng)? onDragEnd,
  }) {
    return Marker(
      markerId: const MarkerId('selectedPlace'),
      position: position,
      infoWindow: InfoWindow(
        title: description,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      draggable: true,
      onDragEnd: onDragEnd,
    );
  }
}
