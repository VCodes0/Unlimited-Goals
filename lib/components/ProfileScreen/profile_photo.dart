import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePhoto extends StatefulWidget {
  const ProfilePhoto({super.key});

  @override
  State<ProfilePhoto> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends State<ProfilePhoto> {
  ImageProvider? _imageProvider;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            _showImagePicker(context);
          },
          child: CircleAvatar(
            radius: 125,
            backgroundColor: Colors.grey[300],
            backgroundImage: _imageProvider,
            child: _imageProvider == null
                ? const Icon(Icons.person, size: 80, color: Colors.white)
                : null,
          ),
        ),
        Positioned(
          bottom: 27,
          right: 8,
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 30,
            child: IconButton(
              icon: const Icon(
                Icons.camera_alt,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () {
                _showImagePicker(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showImagePicker(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
      ),
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          // Use SafeArea for notch/status bar
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Add padding
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    "Pick Your Image Here",
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: "Roboto",
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildImagePickerOption(
                      image: 'assets/images/camera.png',
                      text: 'Camera',
                      onTap: () {
                        Navigator.pop(context);
                        _getImageFromCamera();
                      },
                    ),
                    _buildImagePickerOption(
                      image: 'assets/images/picture.png',
                      text: 'Gallery',
                      onTap: () {
                        Navigator.pop(context);
                        _getImageFromGallery();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildImagePickerOption({
    required String image,
    required String text,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(image, height: 75),
          Text(text),
        ],
      ),
    );
  }

  Future<void> _getImageFromGallery() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageProvider = FileImage(File(pickedFile.path));
      });
    }
  }

  Future<void> _getImageFromCamera() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _imageProvider = FileImage(File(pickedFile.path));
      });
    }
  }
}
