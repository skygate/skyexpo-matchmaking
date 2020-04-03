import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart' show FontSize, semiBoldFontWeight;

class ImagePickerBody extends StatelessWidget {
  final Widget topChild;
  final String title;
  final String subTitle;

  ImagePickerBody(
      {@required this.topChild, @required this.title, @required this.subTitle});

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          topChild,
          Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(title,
                  style: TextStyle(
                      fontSize: FontSize.normal.value,
                      fontWeight: semiBoldFontWeight))),
          Text(subTitle, style: TextStyle(fontSize: FontSize.small.value)),
        ],
      );
}
