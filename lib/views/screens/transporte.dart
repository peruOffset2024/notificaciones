import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/views/screens/guias_servicios_multiples.dart';
import 'package:push_notificaciones/views/screens/guias_ventas_multiples.dart';

import 'package:push_notificaciones/views/screens/usuario_drawer.dart';

class GuiasServicios extends StatefulWidget {
  const GuiasServicios({super.key});

  @override
  State<GuiasServicios> createState() => _GuiasServiciosState();
}

class _GuiasServiciosState extends State<GuiasServicios> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<Authprovider>().conductor;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
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
      backgroundColor: Colors.white, //  background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center content horizontally
                children: [
                  const SizedBox(height: 20.0),
                  _buildServiceButton(
                      context: context,
                      label: 'Guias de Venta',
                      icon:
                          Icons.file_copy_outlined, // Material icon for guides
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const GuiasVentasSeleccionadas(),
                            transitionDuration:
                                const Duration(milliseconds: 350),
                            transitionsBuilder: (context, animation,
                                animationSecondary, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                          ),
                        );
                      }),
                  const SizedBox(height: 20.0),
                  _buildService(
                      context: context,
                      label: 'Guias de Servicio',
                      icon: Icons.local_shipping, // Material de Servicios
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const GuiasServiciosMultiples(),
                            transitionDuration:
                                const Duration(milliseconds: 350),
                            transitionsBuilder: (context, animation,
                                animationSecondary, child) {
                              return SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(1.0, 0.0),
                                  end: Offset.zero,
                                ).animate(animation),
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            },
                          ),
                        );
                      }),
                  const SizedBox(height: 20.0),
                  /*_ServiceButton(
                    context: context,
                    label: 'Otras Guias',
                    icon: Icons
                        .more_horiz_outlined, // Material de otros Servicios
                    onPressed: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const GuiasVentasSeleccionadas(),
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
                  ),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildService({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 100,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.amber[700],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        highlightColor: Colors.green.withOpacity(0.7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                const SizedBox(width: 10.0),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white,
              size: 18.0,
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildServiceButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 100,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        highlightColor: Colors.green.withOpacity(0.7),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                const SizedBox(width: 10.0),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Colors.white,
              size: 18.0,
            ),
          ],
        ),
      ),
    );
  }
}
