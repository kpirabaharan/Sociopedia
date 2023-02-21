import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({super.key});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    File? _storedImage;

    Future<void> _takePicture() async {
      final picker = ImagePicker();
      XFile? pickedXFile;

      pickedXFile = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 600,
      );

      if (pickedXFile == null) {
        return;
      }

      final imageFile = File(pickedXFile.path);

      setState(() {
        _storedImage = imageFile;
      });
    }

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      color: Colors.white,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
          ),
          CircleAvatar(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.multiline,
              maxLength: 255,
              maxLines: 1,
            ),
          ),
          IconButton(
            onPressed: () => {},
            icon: Icon(Icons.camera),
          ),
        ],
      ),
    );

    // Card(
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(30.0),
    //   ),
    //   elevation: 8.0,
    //   child: ListTile(
    //     leading: CircleAvatar(),
    //     title: TextField(
    //       keyboardType: TextInputType.multiline,
    //       maxLines: 3,
    //     ),
    //     trailing: IconButton(
    //       onPressed: () => {},
    //       icon: const Icon(
    //         Icons.camera,
    //       ),
    //     ),
    //   ),
    // );
  }
}
