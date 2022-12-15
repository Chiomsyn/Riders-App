import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/model/address.dart';
import '../../domain/map/api_methods.dart';

class PositionProvider with ChangeNotifier {
  GoogleMapController? controllerGoogleMap;
  final Completer<GoogleMapController> controllerMapCompleter = Completer();

  Address? _pickUpLocation = Address(placeName: 'Add Home');
  Address? _dropOffLocation = Address(placeName: '');

  Position? currentPosition;

  Address? get pickUpLocation => _pickUpLocation;
  Address? get dropOffLocation => _dropOffLocation;

  set updatePickUpLocation(Address pickUpAddress) {
    _pickUpLocation = pickUpAddress;
    notifyListeners();
  }

  set updateDropOffLocation(Address dropOffLocation) {
    _dropOffLocation = dropOffLocation;
    notifyListeners();
  }

  bool serviceEnabled = true;

  Future<void> locatePosition(context) async {
    // Test if location services are enabled.

    await Geolocator.checkPermission();
    await Geolocator.requestPermission();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);
    CameraPosition cameraPosition =
        CameraPosition(target: latLatPosition, zoom: 14);
    controllerGoogleMap
        ?.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    await ApiMethods.searchCoordinateAddress(position, context);

    // getAvailableDrivers();
  }
}
