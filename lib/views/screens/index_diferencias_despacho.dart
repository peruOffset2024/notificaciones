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
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          'Despachos',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _cleanData,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8)),
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
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
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
    );
  }

  Color _getColorByIndex(int index) {
    List<Color> colors = [
      Colors.pink,
      Colors.green,
      Colors.blue,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.cyan,
      Colors.teal,
      Colors.amber,
      Colors.deepPurple
    ];
    return colors[index % colors.length];
  }
}
