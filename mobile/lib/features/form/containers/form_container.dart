import 'package:flutter/material.dart';
import 'package:mobile/features/form/models/form_field_controller_model.dart';
import 'package:mobile/features/profile_form/mocks/team_avatars_mock.dart';
import 'package:mobile/features/profile_form/widgets/profile_form_widget.dart';

class FormContainer extends StatefulWidget {
  final Map<String, FormFieldController> controllers;
  final Widget child;

  FormContainer({@required this.controllers, @required this.child});

  @override
  _FormContainerState createState() => _FormContainerState();
}

class _FormContainerState extends State<FormContainer> {
  Map<String, FormFieldController> controllers;
  bool hasErrors = false;
  _FormContainerState();

  @override
  void initState() {
    super.initState();
    controllers = widget.controllers;
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
