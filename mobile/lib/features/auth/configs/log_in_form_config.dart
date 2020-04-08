import 'package:union/union.dart';

import 'package:mobile/features/form/models/form_field_controller_model.dart'
    show FormFieldController;
import 'package:mobile/features/form/validators/index.dart'
    show isNotEmptyValidator, isValidEmailValidator, isValidPasswordValidator;

final Map<String, FormFieldController> logInFormConfig = {
  "email": FormFieldController(
      initialValue: ''.asFirst(),
      validators: [isNotEmptyValidator, isValidEmailValidator]),
  "password": FormFieldController(
      initialValue: ''.asFirst(),
      validators: [isNotEmptyValidator, isValidPasswordValidator]),
};
