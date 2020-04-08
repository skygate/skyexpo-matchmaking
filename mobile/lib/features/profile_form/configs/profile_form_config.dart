import 'package:mobile/features/form/models/form_field_controller_model.dart'
    show FormFieldController;
import 'package:mobile/features/form/validators/index.dart'
    show isNotEmptyValidator;
import 'package:union/union.dart';

FormFieldController getDefaultFieldController() => FormFieldController(
    initialValue: ''.asFirst(), validators: [isNotEmptyValidator]);

final Map<String, FormFieldController> profileFormConfig = {
  "avatar": getDefaultFieldController(),
  "phone": FormFieldController(initialValue: ''.asFirst(), validators: []),
  "country": getDefaultFieldController(),
  "proffesion": getDefaultFieldController(),
  "role": getDefaultFieldController(),
  "gender": getDefaultFieldController(),
  "biogram": getDefaultFieldController(),
};
