import 'dart:io';
import 'package:flutter/material.dart';

const double imageSize = 100;

class ImagePickerPreview extends StatelessWidget {
  final File image;

  ImagePickerPreview({@required this.image});

  @override
  Widget build(BuildContext context) => Container(
        height: imageSize,
        width: imageSize,
        margin: EdgeInsets.only(bottom: 20),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.file(
              image,
              fit: BoxFit.cover,
            )),
      );
}
