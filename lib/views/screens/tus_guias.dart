import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/guias_salidar_provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/views/screens/seguimiento_pedido.dart';
import 'package:push_notificaciones/views/screens/skeleton_carga.dart';

class ProductosGridScreen extends StatefulWidget {
  const ProductosGridScreen({super.key});

  @override
  State<ProductosGridScreen> createState() => _ProductosGridScreenState();
}

class _ProductosGridScreenState extends State<ProductosGridScreen> {
  final TextEditingController _cleanData = TextEditingController();




  @override
  void initState() {
    super.initState();

    
    // Fetch guias when the widget is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ruc = context.read<Authprovider>().ruc;
      final dni = context.read<Authprovider>().username;
      context.read<GuiasSalidasProvider>().fetchProductos(dni, ruc);
    });
  }


  @override
  Widget build(BuildContext context) {
    final productosProvider = Provider.of<GuiasSalidasProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            'Tus guias',
            style: TextStyle(
                fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(3.0),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: TextField(
                  controller: _cleanData,
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                            color: Colors.greenAccent.withOpacity(0.5)),
                      ),
                      hintText: 'Filtrar guias',
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.cancel_outlined),
                        onPressed: () {
                          // Limpiar el TextField
                          _cleanData.clear();
                          // Restablecer la lista de productos
                          productosProvider.searchProducto('');
                        },
                      ),
                      prefixIcon: const Icon(color: Colors.black, Icons.search),
                      fillColor: Colors.white,
                      filled: true),
                  onChanged: (query) {
                    productosProvider.searchProducto(query);
                  },
                ),
              ),
              Expanded(child: Consumer<GuiasSalidasProvider>(
                  builder: (context, provider, child) {
                if (provider.isLoading) {
                      // Mostrar shimmer loader mientras se obtienen los datos
                      return ShimmerLoaderWidget();
                    }   
                if (provider.productos.isEmpty) {
                  return const Center(
                    child: Text('no hay resultados'),
                  );
                }
                
                return ListView.builder(
                  itemCount: provider.productos.length,
                  itemBuilder: (context, index) {
                    final indice = provider.productos[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 0.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SeguimientoPedidoScreen(
                                        guia: indice.nroGuia,
                                      )));
                        },
                        child: Card(
                          color: Colors.blue[100],
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          indice.nroGuia,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.start,
                                        ),
                                        // Fila 1: Número de guía
                                        Text(
                                          indice.cliente,
                                          style: const TextStyle(
                                            color: Colors.black,
                                            //fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                          overflow: TextOverflow.visible,
                                          textAlign: TextAlign.start,
                                        ),
                                        // Fila 2: Cliente
                                        Text(
                                          indice.entrega,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // Fila 1: Fecha de emisión
                                        Text(
                                          indice.cant,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.end,
                                        ),
                                        // Fila 2: Cantidad
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Color.fromARGB(255, 161, 188, 211),
                                      size: 15,
                                    )
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
              }))
            ],
          ),
        ),
      ),
    );
  }
}
