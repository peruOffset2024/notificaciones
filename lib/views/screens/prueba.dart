 import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/models/modelo_pedido_evento.dart';
import 'package:push_notificaciones/providers/guia_x_cliente_provider.dart';
import 'package:push_notificaciones/providers/pedido_provider.dart';

class RegistroSalida extends StatefulWidget {
  const RegistroSalida({
    super.key,
    required this.cliente,
    required this.guia,
    required this.cant,
  });

  final String cliente;
  final String guia;
  final String cant;

  @override
  State<RegistroSalida> createState() => _RegistroSalidaState();
}

final TextEditingController _lugarEntrega = TextEditingController();

class _RegistroSalidaState extends State<RegistroSalida> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GuiaxClienteProvider>().obtenerGuiasDetalle(widget.guia);
    });
  }

 

  @override
  Widget build(BuildContext context) {
    final providers = context.watch<GuiaxClienteProvider>().guiaxCliente;
    final screenHeigth = MediaQuery.of(context).size.height;

    final screenWidth = MediaQuery.of(context).size.width;
   

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text(
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
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: isKeyboardVisible ? 75 : 20, right: 10, left: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(widget.cliente,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  const Text(
                    'DETALLE :',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    //textAlign: TextAlign.end,
                  ),

                  Card(
                    color: Colors.white,
                    elevation: 2,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(
                          color: Color.fromARGB(255, 227, 242, 253), width: 2),
                      //borderRadius: BorderRadius.circular(8),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      height: screenHeigth * 0.3,
                      child: ListView.builder(
                        itemCount: providers.length,
                        itemBuilder: (context, index) {
                          final jsonIndice =  providers[index];
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 14.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                     Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              jsonIndice.op,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 10,
                                              ),
                                              overflow: TextOverflow.visible,
                                              textAlign: TextAlign.start,
                                            ),
                                            Text(
                                              jsonIndice.und,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              jsonIndice.cant,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(
                                height: 1.0,
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  const Text(
                    'DIRECCIÓN DE ENTREGA:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                  const Text(
                    'AVENIDA NESTOR GAMBETA URB. CALLAO .LIMA-LIMA-LIMA',
                    textAlign: TextAlign.right,
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                  //------ aqui continuo con la columna padre
                  _buildObservationsField()
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: screenWidth * 0.94,
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

            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: const Color.fromRGBO(64, 64, 64, 1),
                  title: const Text(
                    'Éxito',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  content: const Text(
                    'Se registró correctamente tu salida',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
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

  Widget _buildObservationsField() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'OTRO LUGAR DE ENTREGA',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            style: const TextStyle(color: Colors.black),
            controller: _lugarEntrega,
            maxLines: null,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.comment),
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:
                    BorderSide(color: Colors.greenAccent.withOpacity(0.5)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 14.0, vertical: 5.0),
            ),
          ),
        ],
      ),
    );
  }
}