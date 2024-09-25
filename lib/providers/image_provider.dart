
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;


class ImagenesProvider with ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  // ignore: prefer_final_fields
  List<File> _selectedImages = [];
  bool _isLoading = false;

  List<File> get selectedImages => _selectedImages;
  bool get isLoading => _isLoading;


  Future<void> pickImagesFromGallery() async {
    setLoading(true);
    
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();

    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      List<File> compressedImages = [];
      for (var file in pickedFiles) {
        File compressedFile = await _compressImage(File(file.path));
        compressedImages.add(compressedFile);
      }

      _selectedImages.addAll(compressedImages);
      notifyListeners();
    }
    setLoading(false);
  }

  Future<void> takePhoto() async {
    setLoading(true);
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      File compressedFile = await _compressImage(File(pickedFile.path));
      _selectedImages.add(compressedFile);
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


  void removeImage(File image) {
    _selectedImages.remove(image);
    notifyListeners();
  }
  void clearImages() {
    _selectedImages.clear();
    notifyListeners();
  }
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}






