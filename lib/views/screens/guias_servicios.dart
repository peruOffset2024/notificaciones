import 'package:flutter/material.dart';
import 'package:push_notificaciones/views/screens/geolocalizacion.dart';
import 'package:push_notificaciones/views/screens/lista_guias.dart';


class GuiasServicios extends StatefulWidget {
  const GuiasServicios({super.key});

  @override
  State<GuiasServicios> createState() => _GuiasServiciosState();
}

class _GuiasServiciosState extends State<GuiasServicios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, //  background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment:
                  CrossAxisAlignment.center, // Center content horizontally
              children: [
                const SizedBox(height: 20.0),
                _buildServiceButton(
                  context: context,
                  label: 'Guias',
                  icon: Icons.file_copy_outlined, // Material icon for guides
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  const ListaGuiasReporte()),
                  ),
                ),
                const SizedBox(height: 20.0),
                _buildService(
                  context: context,
                  label: 'Servicios',
                  icon: Icons
                      .delivery_dining_outlined, // Material icon for services
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListaGuiasReporte()),
                  ),
                ),
                const SizedBox(height: 20.0),
                _ServiceButton(
                  context: context,
                  label: 'Otros',
                  icon: Icons.more_horiz_outlined, // Material icon for others
                  onPressed: () {
                    // Add functionality for "Otros" button here (e.g., show a dialog)
                    Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  LocationScreen()),);
                  },
                ),
              ],
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
  Widget _ServiceButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 100,
      width: 250,
      decoration: BoxDecoration(
        color: Colors.grey[400],
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
