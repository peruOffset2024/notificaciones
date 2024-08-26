import 'package:flutter/material.dart';
import 'package:push_notificaciones/views/screens/reporte_ruta.dart'; // Assuming this is the correct path

class GuiasServicios extends StatefulWidget {
  const GuiasServicios({super.key});

  @override
  State<GuiasServicios> createState() => _GuiasServiciosState();
}

class _GuiasServiciosState extends State<GuiasServicios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Spotify-like dark background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center, // Center content horizontally
            children: [
              
              const SizedBox(height: 20.0),
              _buildServiceButton(
                context: context,
                label: 'Guias',
                icon: Icons.file_copy_outlined, // Material icon for guides
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReporteRutas()),
                ),
              ),
              const SizedBox(height: 20.0),
              _buildServiceButton(
                context: context,
                label: 'Servicios',
                icon: Icons.delivery_dining_outlined, // Material icon for services
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ReporteRutas()),
                ),
              ),
              const SizedBox(height: 20.0),
              _buildServiceButton(
                context: context,
                label: 'Otros',
                icon: Icons.more_horiz_outlined, // Material icon for others
                onPressed: () {
                  // Add functionality for "Otros" button here (e.g., show a dialog)
                },
              ),
            ],
          ),
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
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(30.0),
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