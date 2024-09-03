import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/models/modelo_pedido_evento.dart';
import 'package:push_notificaciones/providers/lista_guias_provider.dart';
import 'package:push_notificaciones/providers/location_provider.dart';
import 'package:push_notificaciones/providers/pedido_provider.dart';

class SeguimientoPedidoScreen extends StatefulWidget {
  const SeguimientoPedidoScreen({super.key});

  @override
  State<SeguimientoPedidoScreen> createState() =>
      _SeguimientoPedidoScreenState();
}

class _SeguimientoPedidoScreenState extends State<SeguimientoPedidoScreen> {
  final TextEditingController _observacionController = TextEditingController();
  int _estadoIndex = 0;

  @override
  Widget build(BuildContext context) {
    final estados = context.watch<PedidoProvider>().estados;
   
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Seguimiento de Pedido',
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
            final estado = estados[index];
            final isLast = index == estados.length - 1;
            final locationProv = context.read<LocationProvider>().currentLocation;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildEstadoIcon(isLast),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      child: ListTile(
                        title: Text(
                          estado.estado,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${estado.descripcion}\n${_formatDate(estado.fecha)}',
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: Column(children: [
                          Text(locationProv!.latitude.toString()),
                          Text(locationProv.longitude.toString()),
                        ],),
                        isThreeLine: true,
                      ),
                      onTap: () {
                        if (isLast) {
                          _showDialog(context);
                        }
                      },
                    ),
                  ),
                ],
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

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          title: const Text(
            'Actualizar Estado',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.greenAccent.withOpacity(0.5),
              ),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Observaciones',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _observacionController,
                  style: const TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.comment, color: Colors.black),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Colors.greenAccent.withOpacity(0.5)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.greenAccent),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 10.0),
                  ),
                  maxLines: null,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.greenAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    final provider = context.read<PedidoProvider>();
                    final locationProv = context.read<LocationProvider>().currentLocation;
                    final clienteProvider = context.read<ListaGuiaProvider>().guias;
                    
                    

                    final estadosSecuenciales = [
                      PedidoEstado(
                        estado: 'Destino: ${clienteProvider.first.cliente}',
                        descripcion: clienteProvider.first.llegada, 
                        fecha: DateTime.now(), 
                        latitude: locationProv!.latitude.toString(), longitude: locationProv.longitude.toString(),
                      ),
                      PedidoEstado(
                        estado: 'Salida de: ${clienteProvider.first.cliente} \n -> guia: ${clienteProvider.first.guia} ',
                        descripcion: clienteProvider.first.llegada,
                        fecha: DateTime.now(), latitude: locationProv.latitude.toString(), longitude: locationProv.longitude.toString(),
                      ),
                      PedidoEstado(
                        estado: 'Llegada a PeruOfset Digital',
                        descripcion: 'Lurigancho-La Capitana Cal.- Archipielago Mza. C Lote. 9',
                        fecha: DateTime.now(), latitude: locationProv.latitude.toString(), longitude: locationProv.longitude.toString(),
                      ),
                    ];

                    if (_estadoIndex < estadosSecuenciales.length) {
                      provider.actualizarEstado(estadosSecuenciales[_estadoIndex]);
                      _estadoIndex++;
                    }

                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Guardar',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}";
  }
}
