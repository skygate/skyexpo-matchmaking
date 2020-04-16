import 'package:flutter/material.dart';
import 'package:mobile/config/index.dart' show AppRoute;
import 'package:redux/redux.dart' show Store;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;

import 'package:mobile/store/app_state.dart' show AppState;
import '../models/index.dart' show RegisterRequest;
import '../widgets/auth_form_widget.dart' show AuthForm;
import '../widgets/auth_form_fields_widget.dart' show AuthFormFields;
import '../actions/auth_actions.dart' show RegisterRequestAction;

class RegisterContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => _RegisterContainerWithStateAndProps(
            registerRequestAction: vm.registerRequestAction,
          ));
}

class _RegisterContainerWithStateAndProps extends StatefulWidget {
  final Function registerRequestAction;
  _RegisterContainerWithStateAndProps({@required this.registerRequestAction});

  @override
  _RegisterContainerState createState() => _RegisterContainerState();
}

class _RegisterContainerState
    extends State<_RegisterContainerWithStateAndProps> {
  final formKey = GlobalKey<FormState>();
  Map<String, String> registerFormData;

  @override
  void initState() {
    super.initState();
    registerFormData = {'name': '', 'email': '', 'password': ''};
  }

  void setFormFieldValue(String fieldId, String value) => setState(() {
        registerFormData[fieldId] = value;
      });

  void submitForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      widget.registerRequestAction(RegisterRequest(
          name: registerFormData["name"],
          email: registerFormData['email'],
          password: registerFormData['password']));
    }
  }

  @override
  Widget build(BuildContext context) => AuthForm(
        title: 'Sign in',
        subTitle: 'skyexpo matchmaking platform',
        switchLinkTitle: "Already have acount? Sign up.",
        swichLinkRoute: AppRoute.logIn,
        onFormSubmit: submitForm,
        formWidget: AuthFormFields(
          formKey: formKey,
          setFormFieldValue: setFormFieldValue,
          formData: registerFormData,
          isRegisterForm: true,
        ),
      );
}

class _ViewModel {
  final Function(dynamic) registerRequestAction;
  _ViewModel({@required this.registerRequestAction});

  static _ViewModel fromStore(Store<AppState> store) =>
      _ViewModel(registerRequestAction: (registerRequest) {
        store.dispatch(RegisterRequestAction(registerRequest));
      });
}
