import 'dart:convert';
import 'dart:typed_data'; // Uint8List ke liye
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart'; // kIsWeb ke liye

class ProfileImage with ChangeNotifier {
  Uint8List? webImage; // Web ke liye bytes use karenge
  String base64Image = "";
  final ImagePicker _picker = ImagePicker();

  Future<void> chooseImage(String type) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: type == "camera" ? ImageSource.camera : ImageSource.gallery,
        imageQuality: 50,
      );

      if (image != null) {
        // Web ke liye bytes read karein
        Uint8List imageBytes = await image.readAsBytes();

        webImage = imageBytes;
        base64Image = base64Encode(imageBytes);

        print("Image picked successfully");
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }
}