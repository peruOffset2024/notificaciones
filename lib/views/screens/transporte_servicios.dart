import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/conexion_internet_provider.dart';
import 'package:push_notificaciones/providers/trasnporte_servicios_provider.dart';
import 'package:push_notificaciones/services/scroll_behavior.dart';
import 'package:push_notificaciones/views/screens/registro_salida_servicio.dart';
import 'package:push_notificaciones/views/screens/skltn_guia_emitidas.dart';
import 'package:push_notificaciones/views/screens/vista_sin_internet.dart';

class TransporteServicio extends StatefulWidget {
  const TransporteServicio({super.key});
 
  
  @override
  State<TransporteServicio> createState() => _TransporteServicioState();
}

class _TransporteServicioState extends State<TransporteServicio> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
 
    // Fetch guias when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ruc = context.read<Authprovider>().ruc;
      context.read<TransporteServiciosProvider>().fechtGuiasServicios(ruc);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isConnected = context.watch<ConnectivityProvider>().isConnected;

    return isConnected ? 
    ScrollConfiguration(
      behavior: CustomScrollBehavior(), // Aplica el comportamiento personalizado
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Guias de Servicio',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          // automaticallyImplyLeading: false,
        ),
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              // Fila de búsqueda
              TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.black, fontSize: 12),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _searchController.clear();
                      context.read<TransporteServiciosProvider>().searchGuiaServicio('');
                    },
                    icon: const Icon(Icons.cancel_outlined, color: Colors.black),
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  hintText: 'Filtrar por Nro. Guía',
                  hintStyle: const TextStyle(color: Colors.grey),
                  labelStyle: const TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onChanged: (value) {
                  context.read<TransporteServiciosProvider>().searchGuiaServicio(value);
                },
              ),
              const SizedBox(height: 10),
          
              // Tabla de resultados
              Expanded(
                child: Consumer<TransporteServiciosProvider>(
                  builder: (context, providerS, child) {
                    if(providerS.isLoading){
                      return const ShimmerLoaderWidget();
                    }
                    if (providerS.guiasServicios.isEmpty) {
                      return const Center(
                        child: Text(
                          'No hay resultados',
                          style: TextStyle(color: Colors.black),
                        ),
                      );
                    }
          
                    return ListView.builder(
                      itemCount: providerS.guiasServicios.length,
                      itemBuilder: (context, index) {
                        final guia = providerS.guiasServicios[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 0.0), // Espacio mínimo entre cada Card
                          child: GestureDetector(
                            onTap: () {
        
                              
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ServicioRegistroSalida(
                                    cliente: guia.cliente,
                                    guia: guia.guia,
                                    cant: guia.cant,
                                    llegada: guia.llegada,
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              color: Colors.orange[100],
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.only(right: 16.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Fila 1: Número de guía
                                            Text(
                                              guia.guia,
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.start,
                                            ),
                                            // Fila 2: Cliente
                                            Text(
                                              guia.cliente,
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.visible,
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
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            // Fila 1: Fecha de emisión
                                            Text(
                                              guia.fechaEmision.toString().substring(0, 10),
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                            ),
                                            // Fila 2: Cantidad
                                            Text(
                                              guia.cant,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                color: Colors.black,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.end,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8,),
                                    const Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        // Fila 1: Fecha de emisión
                                        Icon(Icons.arrow_forward_ios,color: Color.fromARGB(255, 161, 188, 211),size: 15)
                                        // Fila 2: Cantidad
                                        
                                      ],
                                    ),
                                  ],
                                 ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ) : const NoInternetScreen();
  }
}