import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:push_notificaciones/providers/location_provider.dart';

class RegistroDatos extends StatefulWidget {
  const RegistroDatos({super.key});

  @override
  State<RegistroDatos> createState() => _RegistroDatosState();
}

class _RegistroDatosState extends State<RegistroDatos> {
  final TextEditingController _observacionController = TextEditingController();

  final List<File> _selectedImages = [];

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    // Obtenemos el LocationProvider
    final locationProvider = context.watch<LocationProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación'),
        
      ),
      body: SingleChildScrollView(
        child: Column(
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (locationProvider.currentLocation != null)
              Column(
                children: [
                  Text(
                    'Latitud: ${locationProvider.currentLocation!.latitude}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Longitud: ${locationProvider.currentLocation!.longitude}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.greenAccent.withOpacity(0.5),
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Observaciones',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: _observacionController,
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.comment, color: Colors.black),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: Colors.greenAccent.withOpacity(0.5)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.greenAccent),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                    ),
                    maxLines: null,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      //final provider = context.read<PedidoProvider>();
                      context.read<LocationProvider>().currentLocation;
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      'Guardar',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(color: Colors.blue)
              ),
              child: Container(
                height: 120,
                width: 170,
                color: Colors.white,
                child: IconButton(
                  onPressed: _showImagePickerOptions,
                icon: const Icon(Icons.camera_front_rounded)),
              ),
            ),
            const SizedBox(height: 20),
            // Mostrar las imágenes seleccionadas
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: _selectedImages.map((image) {
                return Stack(
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
                      child: IconButton(
                        icon: const Icon(Icons.cancel_outlined,
                            color: Colors.white),
                        onPressed: () => _removeImage(image),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
            // Mostrar ubicación obtenida
            const SizedBox(height: 20),
            
          ],
        ),
      ),
    );
  }

  Future<void> _pickImagesFromGallery() async {
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages
            .addAll(pickedFiles.map((file) => File(file.path)).toList());
      });
    }
  }

  Future<void> _takePhoto() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _pickImagesFromGallery();
                },
                child: const Text('Seleccionar imágenes de la galería'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
                child: const Text('Tomar foto con la cámara'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeImage(File image) {
    setState(() {
      _selectedImages.remove(image);
    });
  }
}
