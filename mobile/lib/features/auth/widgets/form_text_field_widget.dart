import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile/common/helpers/compose_validators_helper.dart';
import 'package:mobile/config/colors_config.dart';

import 'package:mobile/config/fonts_config.dart';

final inputDecorator = InputDecoration(
  filled: true,
  border: InputBorder.none,
  focusedBorder: InputBorder.none,
  fillColor: AppColor.iputBackground.value,
);

class FormTextField extends StatelessWidget {
  final String label;
  final String fieldId;
  final Function setFormFieldValue;
  final Iterable<Function> validators;
  final bool isObscureText;

  FormTextField(
      {@required this.label,
      @required this.fieldId,
      @required this.setFormFieldValue,
      this.isObscureText = false,
      this.validators});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: new EdgeInsets.only(bottom: 50.0),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: FontSize.normal.value)),
            TextFormField(
              decoration: inputDecorator,
              obscureText: isObscureText,
              onChanged: (value) => setFormFieldValue(fieldId, value),
              validator: (value) {
                return composeValidators(validators, value);
              },
            ),
          ],
        ));
  }
}
