import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/helpers/compose_validators_helper.dart';
import 'package:mobile/common/validators/is_not_empty_validator.dart';
import 'package:mobile/common/validators/is_valid_email_validator.dart';
import 'package:mobile/config/colors_config.dart';

import 'package:mobile/config/fonts_config.dart';
import 'package:mobile/config/routes_config.dart' show AppRoute, redirect;

class FormField extends StatelessWidget {
  final String title;
  final String subTitle;

  FormField({Key key, @required this.title, @required this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: new EdgeInsets.only(bottom: 50.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Test", style: TextStyle(fontSize: 20)),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Full name',
                filled: true,
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                fillColor: AppColor.iputBackground.value,
              ),
              onSaved: (String value) {
                this._formData.email = value;
              },
              validator: (value) => composeValidators(
                  [isNotEmptyValidator, isValidEmailValidator], value),
            ),
          ],
        ));
  }
}
