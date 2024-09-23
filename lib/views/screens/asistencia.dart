import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/ingreso_salida_provider.dart';
import 'package:push_notificaciones/providers/foto_asistencia_provider.dart';
import 'package:push_notificaciones/views/screens/skeleton_carga_images.dart';
import 'package:push_notificaciones/views/screens/usuario_drawer.dart';

class RegistroAsistencia extends StatefulWidget {
  const RegistroAsistencia({super.key});

  @override
  State<RegistroAsistencia> createState() => _RegistroAsistenciaState();
}

class _RegistroAsistenciaState extends State<RegistroAsistencia> {
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
    final sizeW = MediaQuery.of(context).size.width;
    final sizeH = MediaQuery.of(context).size.height;
    final user = context.watch<Authprovider>().conductor;
    final asistenciaProvider = context.watch<IngresoSalidaAsistencia>();
    final fotoProvider = context.watch<FotoAsistenciaProvider>();

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
      body: Container(
        width: sizeW,
        height: sizeH,
        decoration: const BoxDecoration(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
             
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    
                    children: [
                      // Mostrar imágenes seleccionadas o tomadas
                      
                      const Text(
                        'Foto Registro',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      fotoProvider.isLoading
                          ? GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                              ),
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return const Center(child:  ShimmerCargaImages());
                              })
                          : _selectImages(fotoProvider),

                      const SizedBox(height: 20),
                      // Botón de Ingreso
                      GestureDetector(
                        onTap: asistenciaProvider.ingresoHabilitado
                            ? asistenciaProvider.registrarIngreso
                            : null,
                        child: ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            color: asistenciaProvider.ingresoHabilitado
                                ? Colors.green
                                : Colors.green.withOpacity(0.5),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.login,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'INGRESO',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),

                      // Botón de Salida
                      GestureDetector(
                        onTap: asistenciaProvider.salidaHabilitada
                            ? asistenciaProvider.registrarSalida
                            : null,
                        child: ClipOval(
                          child: Container(
                            width: 100,
                            height: 100,
                            color: asistenciaProvider.salidaHabilitada
                                ? Colors.red
                                : Colors.red.withOpacity(0.5),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'SALIDA',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Es importante registrar tu ingreso y salida',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          _botonSheetModal(context, fotoProvider);
        },
        child: const Icon(
          Icons.camera_alt_outlined,
          color: Colors.white,
          size: 35,
        ),
      ),
    );
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
