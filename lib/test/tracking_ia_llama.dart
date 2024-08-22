import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class Recorrido extends StatefulWidget {
  const Recorrido({super.key});

  @override
  _RecorridoState createState() => _RecorridoState();
}

class _RecorridoState extends State<Recorrido> {
  GoogleMapController? _mapController;
  Marker? _markerA;
  Marker? _markerB;
  Polyline? _polyline;
  bool _isRecorridoActivo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: (controller) {
          _mapController = controller;
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194),
          zoom: 12,
        ),
        markers: {
          _markerA = Marker(
            markerId: MarkerId('A'),
            position: LatLng(37.7749, -122.4194),
          ),
          _markerB = Marker(
            markerId: MarkerId('B'),
            position: LatLng(37.7859, -122.4364),
          ),
        },
        polylines: {
          _polyline = Polyline(
            polylineId: PolylineId('recorrido'),
            points: [
              LatLng(37.7749, -122.4194),
              LatLng(37.7859, -122.4364),
            ],
          ),
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_isRecorridoActivo) {
            _iniciarRecorrido();
          } else {
            _finalizarRecorrido();
          }
        },
        tooltip: _isRecorridoActivo ? 'Finalizar recorrido' : 'Iniciar recorrido',
        child: Icon(_isRecorridoActivo ? Icons.stop : Icons.play_arrow),
      ),
    );
  }

  void _iniciarRecorrido() {
    setState(() {
      _isRecorridoActivo = true;
    });
    // Inicia el recorrido y actualiza la ubicación en tiempo real
  }

  void _finalizarRecorrido() {
    setState(() {
      _isRecorridoActivo = false;
    });
    // Finaliza el recorrido y muestra el resultado
  }
}