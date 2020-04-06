import 'package:mobile/common/validators/validators.dart';
import 'package:mobile/features/form/models/form_field_controller_model.dart';

final Map<String, FormFieldController> profileFormConfig = {
  "avatar": FormFieldController(
      key: "avatar", value: '', validators: [isNotEmptyValidator]),
  "phone": FormFieldController(
      key: "phone", value: '', validators: [isNotEmptyValidator]),
  "country": FormFieldController(
      key: "country", value: '', validators: [isNotEmptyValidator]),
  "proffesion": FormFieldController(
      key: "proffesion", value: '', validators: [isNotEmptyValidator]),
  "role": FormFieldController(
      key: "role", value: '', validators: [isNotEmptyValidator]),
  "gender": FormFieldController(
      key: "gender", value: '', validators: [isNotEmptyValidator]),
};
