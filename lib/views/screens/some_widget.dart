import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/models/modelo_pedido_evento.dart';
import 'package:push_notificaciones/providers/location_provider.dart';
import 'package:push_notificaciones/providers/pedido_provider.dart';

class SomeWidget extends StatefulWidget {
  const SomeWidget({super.key});

 
  @override
  State<SomeWidget> createState() => _SomeWidgetState();
}

class _SomeWidgetState extends State<SomeWidget> {
  @override
  void initState() {
    super.initState();

    // Agregar estados iniciales
    final pedidoProvider = context.read<PedidoProvider>();
    final locationProv = context.read<LocationProvider>().currentLocation;
    pedidoProvider.inicializarEstados([
      PedidoEstado(
        estado: 'Orden de pedido',
        descripcion: 'Paquete en espera',
        fecha: DateTime(2023, 9, 26, 19, 28), latitude: locationProv!.latitude.toString(), longitude: locationProv.longitude.toString(),
      ),
      // Añadir más estados si es necesario
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(); // Construir tu widget aquí
  }
}
