import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/conexion_internet_provider.dart';
import 'package:push_notificaciones/providers/env_img_provider.dart';
import 'package:push_notificaciones/providers/image_provider.dart';
import 'package:push_notificaciones/providers/location_provider.dart';
import 'package:push_notificaciones/views/screens/vista_sin_internet.dart';

class RegistroDatos extends StatefulWidget {
  const RegistroDatos({
    super.key,
    required this.guia,
    required this.inicio,
    required this.llegada,
    required this.fin,
  });

  final String guia;
  final String inicio;
  final String llegada;
  final String fin;

  @override
  State<RegistroDatos> createState() => _RegistroDatosState();
}

class _RegistroDatosState extends State<RegistroDatos> {
  final TextEditingController _observacionController = TextEditingController();
  List<String> _tipeDelivery = ['ENTREGADO', 'RECHAZADO', 'OTRO..'];
  bool isSwitched = false;
  String condicion = '0';
  String? _selectedTipeDelivery;

  @override
  void initState() {
    super.initState();
    // Limpiar las imágenes cuando se inicializa la vista
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ImagenesProvider>().clearImages();
    });
  }

  String _calculo() {
    if (widget.inicio == '' && widget.llegada == '' && widget.fin != '') {
      return widget.fin;
    } else if (widget.inicio == '' &&
        widget.fin == '' &&
        widget.llegada != '') {
      return widget.llegada;
    } else if (widget.llegada == '' &&
        widget.fin == '' &&
        widget.inicio != '') {
      return widget.inicio;
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final locationProvider = context.watch<LocationProvider>();
    final imagenesProvider = context.watch<ImagenesProvider>();
    final isConnected = context.watch<ConnectivityProvider>().isConnected;
    // ignore: unused_local_variable
    final resultado = _calculo(); // Aquí debes llamar a la función

    return isConnected
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: Text('Guia: ${widget.guia}',
                  style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
              centerTitle: true,
              elevation: 0,
              actions: [
                TextButton(
                  onPressed: () {
                    _showImagePickerOptions(imagenesProvider);
                  },
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                KeyboardVisibilityBuilder(
                  builder: (context, isKeyboardVisible) {
                    return Padding(
                      padding: EdgeInsets.only(
                          bottom: isKeyboardVisible ? 100 : 20,
                          right: 8,
                          left: 8),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              'Imagenes',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 20),
                            _buildSelectedImages(imagenesProvider),
                            const SizedBox(height: 20),
                            _buildObservacionInput(),
                            const SizedBox(height: 30),
                            _comboBox('ESTADO DE PEDIDO', _tipeDelivery,
                                _selectedTipeDelivery, (String? valor) {
                              setState(() {
                                _selectedTipeDelivery = valor;
                              });
                            }),
                            const SizedBox(height: 20),
                            _toogleButton()
                            // Espacio adicional para el FAB
                          ],
                        ),
                      ),
                    );
                  },
                ),
                if (imagenesProvider
                    .isLoading) // Mostrar el indicador de carga si isLoading es verdadero
                  Container(
                    color: Colors.white, // Fondo semitransparente
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: Colors.blue,
                            color: Colors.grey[100],
                            strokeWidth: 6.0, // Grosor de la línea
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Cargando, por favor espere...',
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: _buildGuardarFotos(),
          )
        : const NoInternetScreen();
  }

   Widget _toogleButton(){
    return Column(
      children: [
        const Text('Desactivado / Activo'),
        const SizedBox(height: 15,),
        Transform.scale(
              scale: 1.2, // Escala el Switch
              child: Switch(
                
                value: isSwitched,
                
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    condicion = isSwitched ? '1' : '0'; // Asignar 1 cuando esté activo, 0 cuando esté inactivo
                  });
                },
                inactiveThumbColor: Colors.grey[100], // circulo centro
                activeColor: Colors.green,
                inactiveTrackColor: Colors.grey,
              ),
            ),
      ],
    );
      
  
  }


  Widget _comboBox(String title, List<String> items, String? value,
      ValueChanged<String?> onChanged) {
    return widget.llegada == '2'
        ? DropdownButtonFormField<String>(
            iconDisabledColor: Colors.black,
            dropdownColor: Colors.white,
            value: value,
            onChanged: onChanged,
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                // 'ENTREGADO', 'RECHAZADO', 'OTRO..',
                child: Text(
                  item,
                  style: TextStyle(
                    color: item == 'ENTREGADO'
                        ? Colors.green // Si es 'ENTREGADO', usa color verde
                        : item == 'RECHAZADO'
                            ? Colors.red // Si es 'RECHAZADO', usa color rojo
                            : item == 'OTRO..'
                                ? Colors
                                    .amber // Si es 'OTRO..', usa color naranja (amber)
                                : Colors
                                    .black, // Si no coincide, usa color negro
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              );
            }).toList(),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.black, width: 1.0),
              ),
              focusColor: Colors.white,
              labelText: title,
              labelStyle: const TextStyle(
                fontSize: 13,
                color: Colors.grey,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
            ),
          )
        : const Text('');
  }

  Widget _buildObservacionInput() {
    final size = MediaQuery.of(context).size.width;
    return Container(
      width: size,
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 4,
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Observaciones',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            autocorrect: false,
            autofocus: false,
            controller: _observacionController,
            style: const TextStyle(color: Colors.black, fontSize: 14),
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
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 161, 188, 211)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color.fromARGB(255, 161, 188, 211)),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            maxLines: null,
          ),
        ],
      ),
    );
  }

  Widget _buildGuardarFotos() {
    final sizeW = MediaQuery.of(context).size.width;
    final resultado2 = _calculo();
    final latitud = context.watch<LocationProvider>().currentLocation;
    final longitud = context.watch<LocationProvider>().currentLocation;
    final usuario = context.watch<Authprovider>().username;
    final imagen = context.watch<ImagenesProvider>().selectedImages;

    return TextButton(
      onPressed: () async {
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
          await context.read<EnvioImagenesProvider>().enviarDatosConImagenes(
              nroGuia: widget.guia,
              track: resultado2,
              latitud: '${latitud?.latitude}',
              longitud: '${longitud?.longitude}',
              usuario: usuario,
              imagenes: imagen,
              comentario: _observacionController.text,
              condicion: _selectedTipeDelivery, distribucion: condicion);

          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Éxito'),
                content: const Text('Los datos se han guardado correctamente.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el diálogo de éxito
                      Navigator.of(context).pop();
                      Navigator.of(context)
                          .pop(); // Retorna a la página anterior
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } catch (error) {
          // Si hay algún error, muestra un mensaje de error
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop(); // Cierra el indicador de carga
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error: $error'),
                content: const Text(
                    'Hubo un error al guardar los datos. Inténtalo nuevamente.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cierra el diálogo de error
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
    );
  }

  Widget _buildSelectedImages(ImagenesProvider imagenesProvider) {
    return Center(
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: imagenesProvider.selectedImages.map((image) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  image,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 0,
                top: 5,
                right: 0,
                left: 0,
                child: IconButton(
                  icon:
                      const Icon(Icons.delete_forever_sharp, color: Colors.red),
                  onPressed: () => imagenesProvider.removeImage(image),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  void _showImagePickerOptions(ImagenesProvider imagenesProvider) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      backgroundColor: Colors.white,
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
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Selecciona una opción',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
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
                  imagenesProvider.pickImagesFromGallery();
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
                  imagenesProvider.takePhoto();
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
