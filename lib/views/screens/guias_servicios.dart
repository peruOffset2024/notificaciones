import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/miguia_provider.dart';
import 'package:push_notificaciones/views/screens/boton_para_mover_carro.dart';
import 'package:push_notificaciones/views/screens/lista_guias.dart';


class GuiasServicios extends StatefulWidget {
  const GuiasServicios({super.key});

  @override
  State<GuiasServicios> createState() => _GuiasServiciosState();
}

class _GuiasServiciosState extends State<GuiasServicios> {
  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSpotifyButton(
                context: context,
                label: 'Guias',
                onPressed: () {
                  context.read<MiGuiasProvider>().guias;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListaGuias()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildSpotifyButton(
                context: context,
                label: 'Servicios',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListaGuias()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildSpotifyButton(
                context: context,
                label: 'Otros',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ControlView()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSpotifyButton({
    required BuildContext context,
    required String label,
    required VoidCallback onPressed,
  }) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: const EdgeInsets.all(5),
      child: MaterialButton(
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: Colors.green,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.25,
            vertical: size.height * 0.025,
          ),
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
