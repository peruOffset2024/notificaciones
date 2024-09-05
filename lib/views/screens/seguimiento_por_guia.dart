import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/location_provider.dart';
import 'package:push_notificaciones/providers/pedido_provider.dart';

class SeguimientoPorGuia extends StatefulWidget {
  const SeguimientoPorGuia({super.key});

  @override
  State<SeguimientoPorGuia> createState() => _SeguimientoPorGuiaState();
}

class _SeguimientoPorGuiaState extends State<SeguimientoPorGuia> {
  //final TextEditingController _observacionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final estados = context.watch<PedidoProvider>().estados;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Seguimiento por guía',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: estados.length,
          itemBuilder: (context, index) {
            //final estado = estados[index];
           // final isLast = index == estados.length - 1;
            //final locationProv =
                context.read<LocationProvider>().currentLocation;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 60,
                      child: Text(
                        'LLegada',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 2,
                      color: Colors.grey,
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 60,
                      child: Text(
                        'LLegada',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 2,
                      color: Colors.grey,
                    ),
                    const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 60,
                      child: Text(
                        'LLegada',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                   
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildEstadoIcon(bool isLast) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.circle,
          color: isLast ? Colors.black : Colors.blue[100],
          size: 20,
        ),
        if (!isLast)
          Container(
            height: 100,
            width: 2,
            color: Colors.grey,
          ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
  }
}
