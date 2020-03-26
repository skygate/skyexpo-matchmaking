import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobile/config/colors_config.dart' show AppColor;
import 'package:mobile/config/fonts_config.dart' show FontSize;

class SubmitButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  SubmitButton({
    @required this.label,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Container(
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              padding: EdgeInsets.symmetric(vertical: 15),
              onPressed: onPressed,
              color: AppColor.buttonBackground.value,
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(5)),
              child: Text(
                label,
                style: TextStyle(
                    fontSize: FontSize.normal.value,
                    color: AppColor.buttonText.value),
              ),
            )));
  }
}
