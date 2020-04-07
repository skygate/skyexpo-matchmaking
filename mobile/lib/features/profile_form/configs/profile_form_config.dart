import 'package:mobile/common/validators/validators.dart';
import 'package:mobile/features/form/models/form_field_controller_model.dart';

final Map<String, FormFieldController> profileFormConfig = {
  "avatar": FormFieldController(
      key: "avatar", initialValue: '', validators: [isNotEmptyValidator]),
  "phone": FormFieldController(
      key: "phone", initialValue: '', validators: [isNotEmptyValidator]),
  "country": FormFieldController(
      key: "country", initialValue: '', validators: [isNotEmptyValidator]),
  "proffesion": FormFieldController(
      key: "proffesion", initialValue: '', validators: [isNotEmptyValidator]),
  "role": FormFieldController(
      key: "role", initialValue: '', validators: [isNotEmptyValidator]),
  "gender": FormFieldController(
      key: "gender", initialValue: '', validators: [isNotEmptyValidator]),
  "biogram": FormFieldController(
      key: "biogram", initialValue: '', validators: [isNotEmptyValidator]),
};
