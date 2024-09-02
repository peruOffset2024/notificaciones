import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/location_provider.dart';


class LocationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locationProvider = context.watch<LocationProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Location Example"),
      ),
      body: Center(
        child: locationProvider.isLoading
            ? CircularProgressIndicator()  // Muestra un indicador de carga mientras se obtiene la ubicación
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    locationProvider.currentPosition != null
                        ? "Latitude: ${locationProvider.currentPosition!.latitude}, Longitude: ${locationProvider.currentPosition!.longitude}"
                        : "No location data",
                  ),
                  SizedBox(height: 20),
                  Text(locationProvider.locationMessage),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<LocationProvider>().fetchCurrentLocation();
                    },
                    child: Text("Get Current Location"),
                  ),
                ],
              ),
      ),
    );
  }
}
