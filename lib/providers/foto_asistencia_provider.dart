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

  Future<void> ImagesGallery() async {
    setLoading(true);
    final List<XFile>? pickFiles = await _pickerAsistencia.pickMultiImage();

    if (pickFiles != null && pickFiles.isNotEmpty) {
      List<File> compressedImages = [];
      for (var file in pickFiles) {
        File compressedFile = await _compressImagen(File(file.path));
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
      File compressedFile = await _compressImagen(File(pickedFiles.path));
      _selectedImagesAsis.add(compressedFile);
      notifyListeners();
    }
    setLoading(false);
  }

  Future<File> _compressImagen(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final image = img.decodeImage(bytes);

    // comprimier la imagen
    final resized = img.copyResize(image!,
        width: 800, height: 800); // aqui cambias el tamaño
    final compressedBytes = img.encodeJpg(resized, quality: 85);
    final compressedFile = File(imageFile.path)
      ..writeAsBytesSync(compressedBytes);
    return compressedFile;
  }

  void removeImagen(File image) {
    _selectedImagesAsis.remove(image);
    notifyListeners();
  }

  void clearImages() {
    _selectedImagesAsis.clear();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
