import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart' show AppColor;

class ImagePickerPlaceholder extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.only(bottom: 20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColor.elementsBackground.value,
        ),
        child: Icon(Icons.cloud_upload, color: AppColor.icon.value, size: 70),
      );
}
