import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;
  String _locationMessage = "";
  bool _isLoading = false;

  Position? get currentPosition => _currentPosition;
  String get locationMessage => _locationMessage;
  bool get isLoading => _isLoading;

  Future<void> fetchCurrentLocation() async {
    _isLoading = true;
    notifyListeners();

    if (!await Geolocator.isLocationServiceEnabled()) {
      _locationMessage = "Location services are disabled.";
      _isLoading = false;
      notifyListeners();
      return;
    }

    final permission = await _checkAndRequestPermission();

    if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
      _locationMessage = "Location permissions are denied.";
      _isLoading = false;
      notifyListeners();
      return;
    }

    try {
      _currentPosition = await Geolocator.getCurrentPosition(
        // ignore: deprecated_member_use
        desiredAccuracy: LocationAccuracy.high,
      );
      _locationMessage = "Location fetched successfully.";
    } catch (e) {
      _locationMessage = "Failed to get location.";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<LocationPermission> _checkAndRequestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission;
  }
}
