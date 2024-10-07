import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/models/modelo_api_diferencias.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/guias_salidar_provider.dart';
import 'package:push_notificaciones/views/Tests/efectos/shake_widget.dart';
import 'package:push_notificaciones/views/Tests/replica_seguimiento.dart';

class NewInicio extends StatefulWidget {
  const NewInicio({super.key});

  @override
  State<NewInicio> createState() => _NewInicioState();
}

class _NewInicioState extends State<NewInicio> {
  final TextEditingController _cleanData = TextEditingController();
  final ValueNotifier<bool> notifierBottonBarVisible = ValueNotifier(true);
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
    final allData = context.watch<GuiasSalidasProvider>().productos;
    final inserData = context.read<GuiasSalidasProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
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
                            inserData.searchProducto('');
                          },
                        ),
                        prefixIcon:
                            const Icon(color: Colors.black, Icons.search),
                        fillColor: Colors.white,
                        filled: true),
                    onChanged: (query) {
                      inserData.searchProducto(query);
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: allData.length,
                      itemBuilder: (context, index) {
                        final indx = allData[index];
                        return ItemAnimatiom(
                          guias: indx,
                          ontap: () async {
                            notifierBottonBarVisible.value = false;
                            await Navigator.of(context).push(PageRouteBuilder(
                                pageBuilder:
                                    (pageBuilder, animation1, animation2) {
                              return FadeTransition(
                                opacity: animation1,
                                child: ReplicaSeguimiento(
                                  guia: indx.nroGuia,
                                  viaje: indx.viaje,
                                  distribucion: indx.distribucion,
                                  direcEntrega: indx.entrega,
                                  cliente: indx.cliente,
                                  cantidad: indx.cant, tipo: '${indx.tipo}',
                                ),
                              );
                            }));
                            notifierBottonBarVisible.value = false;
                          },
                        );
                      }),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

const imgUrl =
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxmzfCjK0O5AiVgKPBZsUGjX3vTDJ1wg-84A&s';

class ItemAnimatiom extends StatelessWidget {
  const ItemAnimatiom({super.key, required this.guias, required this.ontap});

  final SalidaGuia guias;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    const itenHeigh = 100.0;
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: guias.tipo == '6'
                      ? Colors.blue
                      : guias.tipo == '7'
                          ? Colors.orange
                          : guias.tipo == '9'
                              ? Colors.grey
                              : Colors.green),
              borderRadius: BorderRadius.circular(10)),
          height: 160,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                  child: Container(
                decoration: BoxDecoration(
                    color: guias.tipo == '6'
                        ? Colors.blue[50]
                        : guias.tipo == '7'
                            ? Colors.orange[50]
                            : guias.tipo == '9'
                                ? Colors.grey
                                : Colors.green,
                    borderRadius: BorderRadius.circular(9.0)),
              )),
              Align(
                alignment: Alignment.topCenter,
                child: ShakeWidget(
                  duration: const Duration(milliseconds: 1200),
                  child: SizedBox(
                    height: itenHeigh * 0.6,
                    child: Material(
                      color: Colors.transparent,
                      child: FittedBox(
                          child: Text(guias.nroGuia,
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5)))),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20,
                left: 5,
                child: Container(
                  height: 120,
                  width: 5,
                  color: guias.tipo == '6'
                      ? Colors.blue
                      : guias.tipo == '7'
                          ? Colors.orange
                          : guias.tipo == '9'
                              ? Colors.grey
                              : Colors.green,
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: Text(guias.cant),
              ),
              Positioned(
                  bottom: 20,
                  left: 20,
                  child: FittedBox(
                    child: Text(
                      guias.cliente,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.clip,
                      textAlign: TextAlign.start,
                    ),
                  )),
              Positioned(
                  bottom: 40,
                  left: 20,
                  child: Text(
                    guias.entrega,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  )),
              Positioned(
                  right: 0.0,
                  left: 120.0,
                  bottom: 0.0,
                  top: 0.0,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.local_shipping,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      guias.ultimotrack == '0'
                          ? Row(
                              children: [
                                const CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.green,
                                ),
                                const SizedBox(
                                  width: 1,
                                ),
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.grey[300],
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                CircleAvatar(
                                  radius: 5,
                                  backgroundColor: Colors.grey[300],
                                )
                              ],
                            )
                          : guias.ultimotrack == '1'
                              ? Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.grey[300],
                                    ),
                                    const SizedBox(
                                      width: 1,
                                    ),
                                    const CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.red,
                                    ),
                                    const SizedBox(
                                      width: 1,
                                    ),
                                    CircleAvatar(
                                      radius: 5,
                                      backgroundColor: Colors.grey[300],
                                    ),
                                  ],
                                )
                              : guias.ultimotrack == '2'
                                  ? Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 5,
                                          backgroundColor: Colors.grey[300],
                                        ),
                                        const SizedBox(
                                          width: 1,
                                        ),
                                        CircleAvatar(
                                          radius: 5,
                                          backgroundColor: Colors.grey[300],
                                        ),
                                        const CircleAvatar(
                                          radius: 5,
                                          backgroundColor: Colors.amber,
                                        ),
                                      ],
                                    )
                                  : guias.ultimotrack == '3'
                                      ? Row(
                                          children: [
                                            const CircleAvatar(
                                              radius: 5,
                                              backgroundColor: Colors.green,
                                            ),
                                            const SizedBox(
                                              width: 1,
                                            ),
                                            const CircleAvatar(
                                              radius: 5,
                                              backgroundColor: Colors.green,
                                            ),
                                            CircleAvatar(
                                              radius: 5,
                                              backgroundColor: Colors.grey[300],
                                            ),
                                          ],
                                        )
                                      : CircleAvatar(
                                          radius: 5,
                                          backgroundColor: Colors.grey[300],
                                        ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
