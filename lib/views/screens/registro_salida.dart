import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/models/modelo_pedido_evento.dart';
import 'package:push_notificaciones/providers/pedido_provider.dart';
import 'package:push_notificaciones/providers/reg_sal_switch_provider.dart';


// Pendiente para producción Validar que el usuario no vuelva a ejecutar la salida para esa guia o orden de pedido
// ojo PENDIENTE


class RegistroSalida extends StatefulWidget {
  const RegistroSalida({
    super.key,
    required this.isActive,
    required this.label,
    required this.onChanged,
    required this.cliente, 
    required this.guia, 
  });

  final bool isActive;
  final String label;
  final ValueChanged<bool> onChanged;
  final String cliente; 
  final String guia; 

  @override
  State<RegistroSalida> createState() => _RegistroSalidaState();
}


final TextEditingController _lugarEntrega = TextEditingController();

class _RegistroSalidaState extends State<RegistroSalida> {
  @override
  Widget build(BuildContext context) {
    final switchState = context.watch<SwitchStateProvider>();
    

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title:  Text(
          widget.guia,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
               Text(
                widget.cliente,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSwitch(
                      context, switchState.switch1, switchState.toggleSwitch1),
                  
                ],
              ),
              
              _buildObservationsField(),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
      floatingActionButton: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {
            final provider = context.read<PedidoProvider>();
            provider.actualizarEstado(
              PedidoEstado(
                estado: 'Salida de Perú Offset Digital',
                descripcion: widget.cliente,
                fecha: DateTime.now(),
              ),
            );

            // Mostrar el AlertDialog después de actualizar el estado
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: const Color.fromRGBO(64, 64, 64, 1),
                  title: const Text('Éxito', style: TextStyle(color: Colors.white, fontSize: 25),),
                  content: const Text('Se registró correctamente tu salida', style: TextStyle(color: Colors.white, fontSize: 18),),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Aceptar'),
                    ),
                  ],
                );
              },
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            'Registrar Salida',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSwitch(
      BuildContext context, bool isActive, ValueChanged<bool> onChanged) {
    return Column(
      children: [
        Switch(
          value: isActive,
          onChanged: onChanged,
          activeColor: Colors.blue,
          inactiveThumbColor: Colors.grey[200],
          inactiveTrackColor: Colors.grey[300],
        ),
        const SizedBox(height: 8),
        Text(
          widget.label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  Widget _buildObservationsField() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.blue[300],
        borderRadius: BorderRadius.circular(12),
        //border: Border.all(color: Colors.greenAccent.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Lugar de entrega',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            style: const TextStyle(color: Colors.black),
            controller: _lugarEntrega,
            maxLines: null,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: Colors.greenAccent.withOpacity(0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:  BorderSide(color: Colors.grey),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            ),
          ),
        ],
      ),
    );
  }
}
