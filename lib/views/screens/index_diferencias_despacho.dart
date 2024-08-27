import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/api_diferencias_provider.dart';
import 'package:push_notificaciones/views/screens/seguimiento_pedido.dart';

class ProductosGridScreen extends StatefulWidget {
  const ProductosGridScreen({super.key});

  @override
  State<ProductosGridScreen> createState() => _ProductosGridScreenState();
}

class _ProductosGridScreenState extends State<ProductosGridScreen> {
   final TextEditingController _cleanData = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final productosProvider = Provider.of<ProductosProvider>(context);
    final productos = productosProvider.productos;

    return Scaffold(
      appBar: AppBar(
        backgroundColor:   Colors.white,
        automaticallyImplyLeading: false,
        title: const Text(
          'Reporte de ruta',
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.white,),
        padding: const EdgeInsets.all(8.0),
        child: Padding(
          padding: const  EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only( bottom: 16),
                child: TextField(
                  controller: _cleanData,
                  style:  TextStyle(color: Colors.grey[400], fontSize: 14),
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.grey),
                        ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide:
                              BorderSide(color: Colors.greenAccent.withOpacity(0.5)),
                        ),
                      hintText: '¿Qué guía deseas buscar?',
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
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  itemCount: productos.length,
                  itemBuilder: (context, index) {
                    final producto = productos[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SeguimientoPedidoScreen()));
                      },
                      child: Card(
            
                        color: _getColorByIndex(index),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  producto.descripcion,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  producto.itemCode,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColorByIndex(int index) {
    List<Color> colors = [
    
      Colors.green,
     
    ];
    return colors[index % colors.length];
  }
}
