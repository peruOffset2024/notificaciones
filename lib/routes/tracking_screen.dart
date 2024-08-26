import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/tracking_provider.dart';

class RutaDetailsScreen extends StatefulWidget {
  const RutaDetailsScreen({
    super.key,
  });

  @override
  State<RutaDetailsScreen> createState() => _RutaDetailsScreenState();
}

class _RutaDetailsScreenState extends State<RutaDetailsScreen> {
  final TextEditingController _observacionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final location = context.watch<TrackingProvider>().currentLocation;
    final locations = context.watch<TrackingProvider>().locations;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Seguimiento de Ubicación',
          style: TextStyle(color: Colors.greenAccent),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Indicador de progreso
          Positioned(
            top: 20,
            left: 20,
            right: 20,
            child: LinearProgressIndicator(
              value: context.watch<TrackingProvider>().progress,
              backgroundColor: Colors.white.withOpacity(0.3),
              valueColor: const AlwaysStoppedAnimation<Color>(
                  Color.fromARGB(255, 0, 0, 0)),
            ),
          ),

          // Contenedores verdes para cada punto
          ...locations.map((loc) {
            return Positioned(
              left: loc.x + 30, // Ajuste horizontal para centrar el contenedor
              top: loc.y - 1, // Ajuste vertical para centrar el contenedor
              child: Container(
                width: 100,
                height: 100,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  loc.name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }).toList(),

          // Movimiento del carro
          AnimatedPositioned(
            duration: const Duration(seconds: 1),
            left: location.x + 56, // Ajustar la posición horizontal del carro
            top: location.y + 33, // Ajustar la posición vertical del carro
            child: GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shadowColor: Colors.red,
                      surfaceTintColor: Colors.blue,
                      iconColor: Colors.amber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      backgroundColor: Colors.black,
                      elevation: 0,
                      title: const Text(
                        'Destino',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.greenAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      content: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.greenAccent.withOpacity(0.5),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Observaciones',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.greenAccent,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxHeight: 200),
                                child: Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.8, // Ajusta el ancho aquí
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1, color: Colors.grey),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: TextField(
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    controller: _observacionController,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      fillColor: Colors.black,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: BorderSide(
                                          color: Colors.greenAccent
                                              .withOpacity(0.5),
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide: const BorderSide(
                                            color: Colors.greenAccent),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                        horizontal: 16.0,
                                        vertical: 10.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.greenAccent,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                onPressed: () {},
                                child: const Text(
                                  '  Guardar  ',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(
                Icons.directions_car,
                size: 50,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.read<TrackingProvider>().moveToNextLocation(),
        label: const Text('Next'),
        icon: const Icon(Icons.navigation),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}
