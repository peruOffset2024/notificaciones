import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/asistencia_provider_v.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/foto_asistencia_provider.dart';
import 'package:push_notificaciones/providers/location_provider.dart';
import 'package:push_notificaciones/views/screens/skeleton_carga_images.dart';

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
 

  final TextEditingController _observacionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final fotoProvider = context.watch<FotoAsistenciaProvider>();
    final sizeW = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          
          actions: [
            FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {
                _botonSheetModal(context, fotoProvider);
              },
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Foto Registro',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Imagenes',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        // Aquí se muestra el shimmer mientras las imágenes están cargando
                        fotoProvider.isLoading
                            ? GridView.builder(
                                // `shrinkWrap: true` indica que el GridView solo ocupará el espacio necesario para sus elementos.
                                // No expandirá su tamaño más allá del contenido visible.
                                shrinkWrap: true,

                                // `physics: NeverScrollableScrollPhysics()` desactiva el desplazamiento del GridView,
                                // ya que será contenido dentro de otro scroll (como un ScrollView o ListView).
                                physics: const NeverScrollableScrollPhysics(),

                                // `gridDelegate` define el diseño de la cuadrícula. En este caso, `SliverGridDelegateWithFixedCrossAxisCount`
                                // crea una cuadrícula con un número fijo de columnas. Aquí hay 3 columnas en total.
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount:
                                      3, // Número de columnas en la cuadrícula, en este caso 3.
                                  crossAxisSpacing:
                                      8, // Espaciado horizontal entre los elementos de la cuadrícula.
                                  mainAxisSpacing:
                                      8, // Espaciado vertical entre los elementos de la cuadrícula.
                                ),

                                // `itemCount` especifica cuántos elementos o widgets mostrará el GridView.
                                // En este caso, se muestran 6 placeholders.
                                itemCount:
                                    6, // Número de placeholders que quieres mostrar

                                // `itemBuilder` es la función que genera cada uno de los widgets que se mostrarán en el GridView.
                                // Recibe el contexto y el índice de cada widget y construye el widget correspondiente.
                                itemBuilder: (context, index) {
                                  // Aquí estamos mostrando el widget `ShimmerCargaImages` como un placeholder en cada celda de la cuadrícula.
                                  return const ShimmerCargaImages();
                                },
                              )
                            : _selectImages(fotoProvider),
                        const SizedBox(height: 20),
                        Text('tipo ${widget.tipo1}'),

                        const SizedBox(height: 30),

                        const SizedBox(height: 20),
                        //_toogleButton()
                        // Espacio adicional para el FAB
                        Container(
                          height: 100,
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              const Text(
                                'Observaciones',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                autocorrect: false,
                                autofocus: false,
                                controller: _observacionController,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 14),
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.comment,
                                    color: Colors.black,
                                    size: 22,
                                  ),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 161, 188, 211)),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: const BorderSide(
                                        color:
                                            Color.fromARGB(255, 161, 188, 211)),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                ),
                                maxLines: null,
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
        floatingActionButton: TextButton(
          onPressed: () async {
            // parametros por usar
            final usuario = context.read<Authprovider>().username;
            final latitud = context.read<LocationProvider>().currentLocation;
            final longitud = context.read<LocationProvider>().currentLocation;

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
                  comentario: _observacionController.text,
                  tipo: widget.tipo1,
                  imagens: fotoProvider.selectedImagesAsis);
              print('usuario : --> $usuario');
              print('latitude : --> ${latitud?.latitude}');
              print('longitude : --> ${latitud?.longitude}');
              print(
                  '_observacionController : --> ${_observacionController.text}');
              print('Images : --> ${fotoProvider.selectedImagesAsis}');

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
                      'error al enviar datos al servidor',
                      style: TextStyle(fontSize: 14),
                    ),
                    backgroundColor: Colors.red[100],
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
                          Navigator.of(context)
                              .pop(); // Cierra el diálogo de error
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
                Icon(Icons.save, size: 25, color: Colors.white),
                SizedBox(width: 10),
                Text('Guardar',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ],
            ),
          ),
        ));
  }

  Widget _selectImages(FotoAsistenciaProvider fotoProvider) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: fotoProvider.selectedImagesAsis
          .map((image) => Stack(
                children: [
                  Image.file(
                    image,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        fotoProvider.removeImagen(image);
                      },
                      child: const Icon(
                        Icons.close,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
              ))
          .toList(),
    );
  }

  Future<dynamic> _botonSheetModal(
      BuildContext context, FotoAsistenciaProvider fotoProvider) {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
        ),
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 60,
                  height: 5,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10)),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Seleccione un opción',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                Divider(color: Colors.grey[300]),
                ListTile(
                  leading: Icon(Icons.photo_library, color: Colors.blue[100]),
                  title: const Text(
                    'Galería',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    fotoProvider.ImagesGallery();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera, color: Colors.blue[100]),
                  title: const Text(
                    'Cámara',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    fotoProvider.takePhotoAsist();
                  },
                ),
              ],
            ),
          );
        });
  }
}
