import 'package:flutter/material.dart';

import 'package:mobile/config/index.dart' show AppColor;
import 'package:mobile/features/form/models/form_field_controller_model.dart'
    show FormFieldController;

import 'form_field_wrapper_widget.dart';

InputDecoration getInputDecorator(Widget suffix) => InputDecoration(
    filled: true,
    border: InputBorder.none,
    focusedBorder: InputBorder.none,
    fillColor: AppColor.inputBackground.value,
    suffix: suffix);

class FormTextField extends StatefulWidget {
  final String label;
  final Iterable<Function> validators;
  final bool isObscureText;
  final Widget suffix;
  final FormFieldController controller;

  FormTextField(
      {@required this.label,
      @required this.controller,
      this.isObscureText = false,
      this.validators,
      this.suffix});

  _FormTextFieldState createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        widget.controller.handleBlur();
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FormFieldWrapper(
        label: widget.label,
        controller: widget.controller,
        child: TextFormField(
          focusNode: _focusNode,
          decoration: getInputDecorator(widget.suffix),
          obscureText: widget.isObscureText,
          onChanged: widget.controller.handleChange,
        ),
      );
}
