import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage with ChangeNotifier {
  File? selectedImage;
  String base64Image = "";
  final ImagePicker _picker = ImagePicker();
  File? get profileImage => selectedImage;
  Future<void> chooseImage(String type) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: type == "camera" ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50,
      );

      if (image != null) {
        selectedImage = File(image.path);
        //  Base64 string bade size ki hoti hai,
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        print(profileImage);
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }
}