import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({required this.imagePickerFn});

  final void Function(File? pickedImage) imagePickerFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  Future _imagePicker() async {
    final image = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 150);
    setState(() {
      _pickedImage = File(image!.path);
    });
    widget.imagePickerFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: MediaQuery.of(context).size.width * 0.1,
          backgroundColor: Theme.of(context).accentColor,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage!) : null,
          child: _pickedImage == null
              ? const Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                )
              : null,
        ),
        FlatButton.icon(
          onPressed: _imagePicker,
          icon: const Icon(Icons.image),
          label: const Text('Upload image'),
          textColor: Theme.of(context).accentColor,
        ),
      ],
    );
  }
}
