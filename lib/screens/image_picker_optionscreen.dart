import 'package:expense_tracker/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfileHelper {
  static void showImagePicker(BuildContext context) {

    final provider = Provider.of<ProfileImage>(context, listen: false);

    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("Choose Profile Photo",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOption(Icons.image, "Gallery", () {
                  Get.back();
                  provider.chooseImage("gallery"); // Function call kiya
                }),
                _buildOption(Icons.camera_alt, "Camera", () {
                  Get.back();
                  provider.chooseImage("camera"); // Function call kiya
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  static Widget _buildOption(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue.shade50,
            child: Icon(icon, size: 30, color: Colors.blue),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 16, color: Colors.black)),
        ],
      ),
    );
  }
}
