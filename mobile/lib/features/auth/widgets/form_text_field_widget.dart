import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobile/common/helpers/compose_validators_helper.dart'
    show composeValidators;
import 'package:mobile/config/index.dart' show AppColor, FontSize;

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
  final Map<String, String> formValues;

  FormTextField(
      {@required this.label,
      @required this.fieldId,
      @required this.setFormFieldValue,
      @required this.formValues,
      this.isObscureText = false,
      this.validators});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: new EdgeInsets.only(bottom: 24),
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(label,
                  style: TextStyle(fontSize: FontSize.normal.value)),
              margin: EdgeInsets.only(bottom: 12),
            ),
            TextFormField(
              decoration: inputDecorator,
              obscureText: isObscureText,
              onChanged: (value) => setFormFieldValue(fieldId, value),
              validator: (_) =>
                  composeValidators(validators, formValues[fieldId]),
            ),
          ],
        ));
  }
}
