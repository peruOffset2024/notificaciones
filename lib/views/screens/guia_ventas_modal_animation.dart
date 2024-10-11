import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/env_lista_guias_provider.dart';
import 'package:push_notificaciones/providers/guias_ventas_mult_provider.dart';
import 'package:push_notificaciones/providers/location_provider.dart';
import 'package:push_notificaciones/providers/modal_switch_provider.dart';
import 'package:push_notificaciones/providers/multiples_guias_provider.dart';

const _buttonSizeWidth = 160.0;
// ignore: unused_element
const _buttonSizeHeigth = 60.0;
const _buttonCircularSize = 60.0;
// ignore: unused_element
const _finalImageSize = 30.0;
// ignore: unused_element
const _iamgenSize = 120.0;

class ModalGuiasVentasAnimadas extends StatefulWidget {
  const ModalGuiasVentasAnimadas({super.key});

  @override
  State<ModalGuiasVentasAnimadas> createState() =>
      _ModalGuiasVentasAnimadasState();
}

class _ModalGuiasVentasAnimadasState extends State<ModalGuiasVentasAnimadas>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animationResize;
  late Animation _animationMovementIn;
  late Animation _animationMovementOut;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _animationResize = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: _controller, curve: (const Interval(0.0, 0.4))));
    _animationMovementIn = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve:
            (const Interval(0.3, 0.6, curve: Curves.fastLinearToSlowEaseIn))));
    _animationMovementOut = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: (const Interval(0.6, 1.0, curve: Curves.elasticIn))));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pop(true); // Cierra la animación
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildPanel() {
    final size = MediaQuery.of(context).size;

    return Container(
      height: (size.height * 0.8 * _animationResize.value)
          .clamp(_buttonCircularSize, size.height * 0.8),
      width: (size.width * _animationResize.value)
          .clamp(_buttonCircularSize, size.width),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(30),
              topRight: const Radius.circular(30),
              bottomLeft: _animationResize.value == 1
                  ? const Radius.circular(0)
                  : const Radius.circular(30),
              bottomRight: _animationResize.value == 1
                  ? const Radius.circular(0)
                  : const Radius.circular(30))),
      child: Column(
        mainAxisAlignment: _animationResize.value == 1
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          if (_animationResize.value == 1)
            const Text(
              'Guias\n Seleccionadas:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              textAlign: TextAlign.center,
            ),
          // Aquí controlamos la visibilidad de los chips cuando el panel se está reduciendo
          Expanded(
            child: Consumer<EnviarListaGuiasProvider>(
                builder: (context, guiasSeleccionadasPro, child) {
              // Mostrar los chips solo cuando el panel no está en su forma más pequeña
              if (_animationResize.value > 0.7) {
                return guiasSeleccionadasPro.guiasSeleccionadas.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Wrap(
                          spacing: 8.0,
                          children: guiasSeleccionadasPro.guiasSeleccionadas
                              .map((guia) {
                            return Chip(
                                labelPadding:
                                    const EdgeInsets.symmetric(horizontal: 2),
                                label: Text(
                                  guia,
                                  style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                backgroundColor: Colors.grey[300],
                                deleteIconColor: Colors.red,
                                onDeleted: () {
                                  setState(() {
                                    guiasSeleccionadasPro.eliminarGuia(guia);
                                    if (guiasSeleccionadasPro
                                        .guiasSeleccionadas.isEmpty) {
                                      Navigator.of(context).pop();
                                    }
                                  });
                                });
                          }).toList(),
                        ),
                      )
                    : const SizedBox.shrink();
              } else {
                // Cuando el panel está en su forma reducida, mostramos un contenedor vacío
                return const SizedBox.shrink();
              }
            }),
          ),
        ],
      ),
    );
  }

  @override
Widget build(BuildContext context) {
  final size = MediaQuery.of(context).size;
  final orientation = MediaQuery.of(context).orientation; // Detectar orientación

  return Material(
    color: Colors.transparent,
    child: AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final buttonSizeWidth = (_buttonSizeWidth * _animationResize.value)
            .clamp(_buttonCircularSize, _buttonSizeWidth);
        final panelSizeWidth = (size.width * _animationResize.value)
            .clamp(_buttonCircularSize, size.width);

        // Ajustar la posición según la orientación
        double topPosition;
        if (orientation == Orientation.portrait) {
          // Modo vertical
          topPosition = size.height * 0.4 +
              (_animationMovementIn.value * size.height * 0.4309);
        } else {
          // Modo horizontal (landscape), ajustamos el valor de "top"
          topPosition = size.height * 0.2 +
              (_animationMovementIn.value * size.height * 0.452);
        }

        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
            Positioned.fill(
              child: Stack(
                children: [
                  if (_animationMovementIn.value != 1)
                    Positioned(
                      top: topPosition, // Posición ajustada según la orientación
                      left: size.width / 2 - panelSizeWidth / 2,
                      child: _buildPanel(),
                    ),
                  Positioned(
                    left: size.width / 2 - buttonSizeWidth / 2,
                    bottom: 40.0 - (_animationMovementOut.value * 100),
                    child: InkWell(
                      onTap: () async {
                        _controller.forward();
                        try {
                          final guias = context
                              .read<EnviarListaGuiasProvider>()
                              .guiasSeleccionadas;
                          final usuario = context.read<Authprovider>().username;
                          final longitud = context
                              .read<LocationProvider>()
                              .currentLocation
                              ?.longitude;
                          final latitud = context
                              .read<LocationProvider>()
                              .currentLocation
                              ?.latitude;

                          await context
                              .read<MultiplesGuiasProvider>()
                              .enviarMultiplesGuias(guias, '', usuario,
                                  '$latitud', '$longitud', '0');
                          
                          // ignore: use_build_context_synchronously
                          context
                              .read<ListaGuiaProvider>()
                              .eliminarVariasGuias(guias);

                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'TU REGISTRO DE SALIDA SE REALIZÓ CORRECTAMENTE.',
                                style: TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        } catch (error) {
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'ERROR: LAS GUIAS YA TIENE SALIDA. \n$error',
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }

                        // ignore: use_build_context_synchronously
                        context.read<EnviarListaGuiasProvider>().limpiar();
                        // ignore: use_build_context_synchronously
                        context.read<ModalSwitchProvider>().switchClear();
                      },
                      child: Container(
                        width: buttonSizeWidth,
                        height: _buttonCircularSize,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                        child: const Center(
                          child: Text(
                            'Registrar\n  Salida',
                            style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    ),
  );
}

}
