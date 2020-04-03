import 'dart:io';

import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:mobile/common/widgets/form_field_wrapper_widget.dart'
    show FormFieldWrapper;
import 'package:mobile/config/index.dart'
    show AppColor, FontSize, semiBoldFontWeight;

class ImagePicker extends StatefulWidget {
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  File _image;

  Future getImage() async {
    final image = await image_picker.ImagePicker.pickImage(
        source: image_picker.ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FormFieldWrapper(
        label: 'Upload profile photo',
        child: GestureDetector(
            onTap: getImage,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                color: AppColor.inputBackground.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.elementsBackground.value,
                      ),
                      child: Icon(Icons.cloud_upload,
                          color: AppColor.icon.value, size: 70),
                    ),
                    Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text('Select a image',
                            style: TextStyle(
                                fontSize: FontSize.normal.value,
                                fontWeight: semiBoldFontWeight))),
                    Text('PNG, JPG or GIF under 1MB in size',
                        style: TextStyle(fontSize: FontSize.small.value)),
                  ],
                ))));
  }
}
