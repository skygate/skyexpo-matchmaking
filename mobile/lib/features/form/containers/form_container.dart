import 'package:flutter/material.dart';
import 'package:mobile/features/form/models/form_field_controller_model.dart';
import 'package:mobile/features/profile_form/mocks/team_avatars_mock.dart';
import 'package:mobile/features/profile_form/widgets/profile_form_widget.dart';

getForm(Widget child) {
  return FormContainer(child: child);
}

class FormContainer extends StatefulWidget {
  final Map<String, FormFieldController> formControllersInit;
  final Widget child;

  FormContainer({@required this.child, @required this.formControllersInit});

  @override
  _FormContainerState createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  Map<String, FormFieldController> controllers;

  _FormContainerState();

  @override
  void initState() {
    super.initState();
    controllers = widget.formControllersInit;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
