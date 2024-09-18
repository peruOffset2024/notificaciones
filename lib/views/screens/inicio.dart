import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/guias_salidar_provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/views/screens/seguimiento_pedido.dart';
import 'package:push_notificaciones/views/screens/skltn_guia_emitidas.dart';
import 'package:push_notificaciones/views/screens/usuario_drawer.dart';

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
  void didChangeDependencies() {
    
    super.didChangeDependencies();
  }
  
  Future<void> _refreshData() async {
    final ruc = context.read<Authprovider>().ruc;
    final dni = context.read<Authprovider>().username;
    await context.read<GuiasSalidasProvider>().fetchProductos(dni, ruc);
  }

  @override
  Widget build(BuildContext context) {
    final productosProvider = Provider.of<GuiasSalidasProvider>(context);
    final user = context.watch<Authprovider>().conductor;

    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'Tus guias',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Builder(builder: (context) {
              return GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.red[100],
                  minRadius: 25,
                  child: Text(
                    user[0].toUpperCase(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                onTap: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            }),
            const SizedBox(width: 10),
          ],
        ),
        drawer: MyCustomDrawer(usuario: user),
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
                        prefixIcon:
                            const Icon(color: Colors.black, Icons.search),
                        fillColor: Colors.white,
                        filled: true),
                    onChanged: (query) {
                      productosProvider.searchProducto(query);
                    },
                  ),
                ),
                Expanded(child: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: Consumer<GuiasSalidasProvider>(
                      builder: (context, provider, child) {
                    if (provider.isLoading) {
                      // Mostrar shimmer Loading mientras se obtienen los datos
                      return const ShimmerLoaderWidget();
                    }
                    if (provider.productos.isEmpty) {
                      return const Center(
                        child: Text('No hay guias registradas.'),
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
                                  PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          SeguimientoPedidoScreen(
                                              guia: indice.nroGuia),
                                      transitionDuration:
                                          const Duration(milliseconds: 350),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        return SlideTransition(
                                          position: Tween<Offset>(
                                            end: Offset.zero,
                                            begin: const Offset(1.0, 0.0),
                                          ).animate(animation),
                                          child: child,
                                        );
                                      }));
                            },
                            child: Card(
                              color: Colors
                                  .white, //indice.tipo == "6" ? Colors.blue[400] : Colors.orange,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: BorderSide(
                                      color: indice.tipo == "6"
                                          ? Colors.blue
                                          : indice.tipo == "7"
                                              ? Colors.orange
                                              : indice.tipo == "9"
                                                  ? Colors.grey
                                                  : Colors.green,
                                      width: 1)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 0.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                        height: 80,
                                        width: 4,
                                        color: indice.tipo == "6"
                                            ? Colors.blue
                                            : indice.tipo == "7"
                                                ? Colors.orange
                                                : indice.tipo == "9"
                                                    ? Colors.grey
                                                    : Colors.green),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16.0),
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
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
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
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                 Icon(
                                                  Icons.local_shipping,
                                                  size: 15,
                                                  color: Colors.grey[400],
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                  
                                                  indice.ultimotrack == '0'
                                                      ? Row(
                                                          children: [
                                                            const CircleAvatar(
                                                              radius: 5,
                                                              backgroundColor:
                                                                  Colors
                                                                      .green,
                                                            ),
                                                            const SizedBox(width: 1,),
                                                            CircleAvatar(
                                                              radius: 5,
                                                              backgroundColor:
                                                                  Colors
                                                                      .grey[300],
                                                            ),
                                                            CircleAvatar(
                                                              radius: 5,
                                                              backgroundColor:
                                                                  Colors
                                                                      .grey[300],
                                                            ),
                                                            
                                                          ],
                                                        )
                                                      :  indice.ultimotrack == '1' ? Row(
                                                          children: [
                                                            const CircleAvatar(
                                                              radius: 5,
                                                              backgroundColor:
                                                                  Colors
                                                                      .green,
                                                            ),
                                                            const SizedBox(width: 1,),
                                                            const CircleAvatar(
                                                              radius: 5,
                                                              backgroundColor:
                                                                  Colors
                                                                      .green,
                                                            ),
                                                            CircleAvatar(
                                                              radius: 5,
                                                              backgroundColor:
                                                                  Colors
                                                                      .grey[300],
                                                            ),
                                                            
                                                          ],
                                                        )
                                                        
                                                        
                                                      : indice.ultimotrack == '2' ? const Row(
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 5,
                                                              backgroundColor:
                                                                  Colors
                                                                      .green,
                                                            ),
                                                            SizedBox(width: 1,),
                                                            CircleAvatar(
                                                              radius: 5,
                                                              backgroundColor:
                                                                  Colors
                                                                      .green,
                                                            ),
                                                            CircleAvatar(
                                                              radius: 5,
                                                              backgroundColor:
                                                                  Colors
                                                                      .green,
                                                            ),
                                                            
                                                          ],
                                                        ): indice.ultimotrack == '3' ? Row(
                                                          children: [
                                                            const CircleAvatar(
                                                              radius: 5,
                                                              backgroundColor:
                                                                  Colors
                                                                      .green,
                                                            ),
                                                            const SizedBox(width: 1,),
                                                            const CircleAvatar(
                                                              radius: 5,
                                                              backgroundColor:
                                                                  Colors
                                                                      .green,
                                                            ),
                                                            CircleAvatar(
                                                              radius: 5,
                                                              backgroundColor:
                                                                  Colors
                                                                      .grey[300],
                                                            ),
                                                            
                                                          ],
                                                        ):
                                                      
                                                       CircleAvatar(
                                                          radius: 5,
                                                          backgroundColor:
                                                              Colors.grey[300],
                                                        ),
                                                // Text('${indice.ultimotrack}', style: TextStyle(color: Colors.black),)
                                              ],
                                            )
                  
                                            // Fila 2: Cantidad
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: indice.tipo == "6"
                                              ? Colors.blue
                                              : indice.tipo == "7"
                                                  ? Colors.orange
                                                  : indice.tipo == "9"
                                                      ? Colors.grey
                                                      : Colors.green,
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
                  }),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
