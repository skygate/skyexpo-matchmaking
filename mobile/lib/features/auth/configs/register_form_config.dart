import 'package:mobile/features/form/models/form_field_controller_model.dart'
    show FormFieldController;
import 'package:mobile/features/form/validators/index.dart'
    show isNotEmptyValidator;
import 'package:mobile/features/auth/configs/log_in_form_config.dart'
    show logInFormConfig;
import 'package:union/union.dart';

final Map<String, FormFieldController> registerFormConfig = {
  "name": FormFieldController(
      initialValue: ''.asFirst(), validators: [isNotEmptyValidator]),
  ...logInFormConfig
};
