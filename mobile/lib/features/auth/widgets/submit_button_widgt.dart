import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/config/colors_config.dart';
import 'package:mobile/config/fonts_config.dart';

class SubmitButton extends StatelessWidget {
  final String label;
  final Function onPressed;

  SubmitButton({
    @required this.label,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          onPressed: onPressed,
          color: AppColor.buttonBackground.value,
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(5)),
          // side: BorderSide(color: Colors.red)),
          child: Text(
            label,
            style: TextStyle(
                fontSize: FontSize.normal.value,
                color: AppColor.buttonText.value),
          ),
        ));
  }
}
