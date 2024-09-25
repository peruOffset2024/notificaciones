import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;

class FotoAsistenciaProvider with ChangeNotifier {
  final ImagePicker _pickerAsistencia = ImagePicker();
  // ignore: prefer_final_fields
  List<File> _selectedImagesAsis = [];
  bool _isLoading = false;

  List<File> get selectedImagesAsis => _selectedImagesAsis;
  bool get isLoading => _isLoading;

  // ignore: non_constant_identifier_names
  Future<void> ImagesGallery() async {
    setLoading(true);
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final List<XFile>? pickFiles = await _pickerAsistencia.pickMultiImage();

    if (pickFiles != null && pickFiles.isNotEmpty) {
      List<File> compressedImages = [];
      for (var file in pickFiles) {
        File compressedFile = await _compressImage(File(file.path));
        compressedImages.add(compressedFile);
      }
      _selectedImagesAsis.addAll(compressedImages);
      notifyListeners();
    }
    setLoading(false);
  }

  Future<void> takePhotoAsist() async {
    setLoading(true);
    final pickedFiles =
        await _pickerAsistencia.pickImage(source: ImageSource.camera);
    if (pickedFiles != null) {
      File compressedFile = await _compressImage(File(pickedFiles.path));
      _selectedImagesAsis.add(compressedFile);
      notifyListeners();
    }
    setLoading(false);
  }

  
  
  //metodo para comprimir la imagen
  Future<File> _compressImage(File imageFile) async {
  final bytes = await imageFile.readAsBytes();
  final image = img.decodeImage(bytes);

  if (image == null) {
    throw Exception('No se pudo decodificar la imagen.');
  }

  // Calcular las nuevas dimensiones reduciendo el 20%
  final int newWidth = (image.width * 0.8).toInt();
  final int newHeight = (image.height * 0.8).toInt();

  // Redimensionar la imagen
  final resized = img.copyResize(image, width: newWidth, height: newHeight);

  // Comprimir la imagen con calidad 85 (puedes ajustar la calidad si es necesario)
  final compressedBytes = img.encodeJpg(resized, quality: 85);

  // Escribir la imagen comprimida a un nuevo archivo
  final compressedFile = File(imageFile.path)..writeAsBytesSync(compressedBytes);

  return compressedFile;
}

  void removeImagen(File image) {
    _selectedImagesAsis.remove(image);
    notifyListeners();
  }

  void clearImages() {
    _selectedImagesAsis.clear();
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
