import 'dart:io';
import 'package:mobile/features/form/widgets/form_field_wrapper_widget.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' as image_picker;

import 'package:mobile/config/index.dart' show AppColor;
import '../helpers/get_file_size_from_bytes.dart';
import 'image_picker_placeholder_widget.dart' show ImagePickerPlaceholder;
import 'image_picker_preview_widget.dart' show ImagePickerPreview;
import 'image_picker_body_widget.dart' show ImagePickerBody;

class ImagePicker extends StatefulWidget {
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  File image;

  Future getImage() async {
    final imageFile = await image_picker.ImagePicker.pickImage(
        source: image_picker.ImageSource.gallery);

    setState(() {
      image = imageFile;
    });
  }

  @override
  Widget build(BuildContext context) => FormFieldWrapper(
      label: 'Upload profile photo',
      child: GestureDetector(
          onTap: getImage,
          child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              color: AppColor.inputBackground.value,
              child: image != null
                  ? ImagePickerBody(
                      topChild: ImagePickerPreview(
                        image: image,
                      ),
                      title: basename(image.path),
                      subTitle:
                          getFileSizeFromBytes(image.lengthSync()).toString(),
                    )
                  : ImagePickerBody(
                      topChild: ImagePickerPlaceholder(),
                      title: 'Select a image',
                      subTitle: 'PNG, JPG or GIF under 1MB in size',
                    ))));
}
