import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/asistencia_provider_v.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/conexion_internet_provider.dart';
import 'package:push_notificaciones/providers/foto_asistencia_provider.dart';
import 'package:push_notificaciones/providers/location_provider.dart';
import 'package:push_notificaciones/providers/tipo_asistencia_provider.dart';
import 'package:push_notificaciones/views/screens/indicador_carga.dart';
import 'package:push_notificaciones/views/screens/vista_sin_internet.dart';



class ConfirmacionAsistencia extends StatefulWidget {
  const ConfirmacionAsistencia({
    super.key,
    required this.tipo1,
  });
  final String tipo1;

  @override
  State<ConfirmacionAsistencia> createState() => _ConfirmacionAsistenciaState();
}

class _ConfirmacionAsistenciaState extends State<ConfirmacionAsistencia> {
  final TextEditingController _comentariosController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Limpiar las imágenes cuando se inicializa la vista
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<FotoAsistenciaProvider>().clearImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    final fotoProvider = context.watch<FotoAsistenciaProvider>();
    final sizeW = MediaQuery.of(context).size.width;
    final usuario = context.watch<Authprovider>().username;
    final nombUsuario = context.watch<Authprovider>().conductor;
    final latitud = context.read<LocationProvider>().currentLocation;
    final longitud = context.read<LocationProvider>().currentLocation;
    final isConnected = context.watch<ConnectivityProvider>().isConnected;
    

    void returnActua() {
      // ignore: avoid_print
      print('Regresando a ASISTENCIA y actualizando los datos --->');
      context.read<TipoAsistenciaProvider>().fechtTipo(usuario);
    }

    // ignore: deprecated_member_use
    return isConnected ? Scaffold( 
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: isKeyboardVisible ? 100 : 20, right: 8, left: 8),
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(nombUsuario, style: const TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.normal),),
                        const SizedBox(height: 40),
                        //--------------------------------------------------------------
                        
                         _photoPreviewSection(context, fotoProvider),
                        //--------------------------------------------------------------
                        const SizedBox(height: 40),
                        // Espacio adicional para el FAB
                        Container(
                          height: 150,
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              TextField(
                                autocorrect: false,
                                autofocus: false,
                                controller: _comentariosController,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 11),
                                decoration: InputDecoration(
                                  labelText: 'Comentarios (Opcional)',
                                  labelStyle:
                                      const TextStyle(color: Colors.black, fontSize: 11),
                                  prefixIcon: const Icon(
                                    Icons.comment,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide:
                                        const BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                ),
                                //maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: fotoProvider.isLoading ? const SizedBox.shrink() : TextButton(
          onPressed: () async {
            // parametros por usar
            showDialog(
                context: context,
                barrierDismissible:
                    false, // para no cerrar el dialogo al tocar fuera el dialog
                builder: (BuildContext context) {
                  return const Dialog(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(width: 20),
                          Text('Cargando...'),
                        ],
                      ),
                    ),
                  );
                });
            try {
              await context.read<EnvirAsistencia>().envirAsistencia(
                  usuario: usuario,
                  latitud: '${latitud?.latitude}',
                  longitud: '${longitud?.longitude}',
                  comentario: _comentariosController.text,
                  tipo: widget.tipo1,
                  imagens: fotoProvider.selectedImagesAsis);
                  // ignore: avoid_print
              print('usuario : --> $usuario');
              // ignore: avoid_print
              print('latitude : --> ${latitud?.latitude}');
              // ignore: avoid_print
              print('longitude : --> ${latitud?.longitude}');
              // ignore: avoid_print
              print(
                  '_observacionController : --> ${_comentariosController.text}');
                  // ignore: avoid_print
              print('Images : --> ${fotoProvider.selectedImagesAsis}');
              _comentariosController.clear();

              showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: Colors.blue[50],
                    title: const Text('Excelente.'),
                    content:
                        const Text('Los datos se han guardado correctamente.'),
                    actions: [
                      TextButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[350],
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                    color: Colors.black38, width: 1))),
                        onPressed: () {
                          returnActua();
                          Navigator.of(context)
                              .pop(); // Cierra el diálogo de éxito
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                          // Retorna a la página anterior
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  );
                },
              );
            } catch (e) {
              showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return AlertDialog(
                    content: const Text(
                      'La imagen es requerida para confirmar su asistencia. ', // $e AQUI ME MUESTRA EL ERROR
                      style: TextStyle(fontSize: 14),
                    ),
                    backgroundColor: Colors.white,
                    actions: [
                      TextButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[350],
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                    color: Colors.black38, width: 1))),
                        onPressed: () {
                          returnActua();
                          Navigator.of(context)
                              .pop(); // Cierra el diálogo de éxito
                          Navigator.of(context).pop();
                          // Cierra el diálogo de error
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue,
            ),
            width: sizeW * 0.95,
            height: 45,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, size: 25, color: Colors.white),
                SizedBox(width: 10),
                Text('Confirmar',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
          ),
        )) : const NoInternetScreen();
  }

  Widget _photoPreviewSection(
  BuildContext context, FotoAsistenciaProvider fotoProvider) {
  
  final image = fotoProvider.selectedImagesAsis.isNotEmpty
      ? fotoProvider.selectedImagesAsis[0]  // Obtener solo la primera imagen
      : null;

  return Column(
    children: [
      GestureDetector(
        onTap: () {
          image != null ? fotoProvider.removeImagen(image) : 
          fotoProvider.takePhotoAsist();  // Función para tomar una nueva foto
        },
        child: Container(
          height: 240,
          width: 240,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: Colors.grey),
          ),
          child: image != null
              ? Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(39),
                      child: Image.file(
                        image,
                        height: 240,
                        width: 240,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Positioned( 
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.cancel,
                          color: Colors.red,
                          size: 50,
                        ),
                        onPressed: () => fotoProvider.removeImagen(image),
                      ),
                    ),
                  ],
                )
              : fotoProvider.isLoading ?  const IndicadorDeCarga() : const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt_outlined,
                        size: 50, color: Colors.black),
                    SizedBox(height: 10),
                    Text('Tomar foto', style: TextStyle(color: Colors.blue)),
                  ],
                ),
        ),
      ),
    ],
  );
}

}
