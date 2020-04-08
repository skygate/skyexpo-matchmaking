import 'package:mobile/common/validators/validators.dart';
import 'package:mobile/features/form/models/form_field_controller_model.dart';

FormFieldController getDefaultFieldController() =>
    FormFieldController(initialValue: '', validators: [isNotEmptyValidator]);

final Map<String, FormFieldController> profileFormConfig = {
  "avatar": getDefaultFieldController(),
  "phone": FormFieldController(initialValue: '', validators: []),
  "country": getDefaultFieldController(),
  "proffesion": getDefaultFieldController(),
  "role": getDefaultFieldController(),
  "gender": getDefaultFieldController(),
  "biogram": getDefaultFieldController(),
};
