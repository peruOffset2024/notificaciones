import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  Location _location = Location();
  LocationData? _currentLocation;
  String _locationMessage = "";
  bool _isLoading = false;
  bool _isLocationEnabled = false; // Nueva variable para controlar si la ubicación está habilitada

  LocationData? get currentLocation => _currentLocation;
  String get locationMessage => _locationMessage;
  bool get isLoading => _isLoading;
  bool get isLocationEnabled => _isLocationEnabled; // Getter para la nueva variable

  LocationProvider() {
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    _isLoading = true;
    notifyListeners();

    bool _serviceEnabled = await _location.serviceEnabled();
    _isLocationEnabled = _serviceEnabled; // Asigna si la ubicación está habilitada
    if (!_serviceEnabled) {
      _serviceEnabled = await _location.requestService();
      _isLocationEnabled = _serviceEnabled; // Actualiza si se habilita el servicio de ubicación
      if (!_serviceEnabled) {
        _locationMessage = "Location services are disabled.";
        _isLoading = false;
        notifyListeners();
        return;
      }
    }

    PermissionStatus _permissionGranted = await _location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        _locationMessage = "Location permissions are denied.";
        _isLoading = false;
        notifyListeners();
        return;
      }
    }

    // Start listening to location changes
    _location.onLocationChanged.listen((LocationData currentLocation) {
      _currentLocation = currentLocation;
      _locationMessage =
          "Latitude: ${currentLocation.latitude}, Longitude: ${currentLocation.longitude}";
      notifyListeners();
    });

    // Initial location fetch
    try {
      _currentLocation = await _location.getLocation();
      _locationMessage =
          "Latitude: ${_currentLocation?.latitude}, Longitude: ${_currentLocation?.longitude}";
    } catch (e) {
      _locationMessage = "Failed to get location.";
    }

    _isLoading = false;
    notifyListeners();
  }
}
