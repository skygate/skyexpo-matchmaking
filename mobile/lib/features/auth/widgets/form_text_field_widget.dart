import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mobile/common/helpers/compose_validators_helper.dart'
    show composeValidators;
import 'package:mobile/config/index.dart' show AppColor, FontSize;

InputDecoration getInputDecorator(Widget suffix) => InputDecoration(
    filled: true,
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    fillColor: AppColor.inputBackground.value,
    suffix: suffix);

class FormTextField extends StatelessWidget {
  final String label;
  final String fieldId;
  final Function setFormFieldValue;
  final Iterable<Function> validators;
  final bool isObscureText;
  final Map<String, String> formValues;
  final Widget suffix;

  FormTextField(
      {@required this.label,
      @required this.fieldId,
      @required this.setFormFieldValue,
      @required this.formValues,
      this.isObscureText = false,
      this.validators,
      this.suffix});

  @override
  Widget build(BuildContext context) => Container(
      margin: new EdgeInsets.only(bottom: 15),
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child:
                Text(label, style: TextStyle(fontSize: FontSize.normal.value)),
            margin: EdgeInsets.only(bottom: 12),
          ),
          TextFormField(
            decoration: getInputDecorator(suffix),
            obscureText: isObscureText,
            onChanged: (value) => setFormFieldValue(fieldId, value),
            validator: (_) =>
                composeValidators(validators, formValues[fieldId]),
          ),
        ],
      ));
}
