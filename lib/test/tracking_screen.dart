import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/tracking_provider.dart';


class TrackingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final locationProvider = Provider.of<TrackingProvider>(context);
    final currentPosition = locationProvider.currentPosition;

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: Text('Seguimiento en tiempo real')),
      body: Stack(
        children: [
          // Aquí puedes agregar una imagen de fondo o un mapa
          Container(color: Colors.grey[300]),

          // Mueve el ícono del carro en función de la posición actual
          if (currentPosition != null)
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              left: _getXFromLongitude(currentPosition.longitude, screenWidth),
              top: _getYFromLatitude(currentPosition.latitude, screenHeight),
              child: Icon(
                Icons.directions_car,
                size: 50,
                color: Colors.red,
              ),
            )
          else
            Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  double _getXFromLongitude(double longitude, double screenWidth) {
    // Convertir la longitud a una posición X en la pantalla
    return (longitude + 180) * (screenWidth / 360);
  }

  double _getYFromLatitude(double latitude, double screenHeight) {
    // Convertir la latitud a una posición Y en la pantalla
    return (90 - latitude) * (screenHeight / 180);
  }
}
