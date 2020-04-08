import 'package:flutter/material.dart';
import 'package:mobile/config/index.dart' show AppRoute;
import 'package:redux/redux.dart' show Store;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;
import 'package:union/union.dart';

import 'package:mobile/store/app_state.dart' show AppState;
import 'package:mobile/features/form/containers/form_container.dart'
    show FormContainer;
import 'package:mobile/features/form/models/form_field_controller_model.dart'
    show FormFieldController;
import 'package:mobile/features/form/models/on_form_submit_type.dart'
    show OnFormSubmit;
import '../configs/register_form_config.dart' show registerFormConfig;
import '../models/index.dart' show RegisterRequest;
import '../widgets/auth_form_widget.dart' show AuthForm;
import '../widgets/auth_form_fields_widget.dart' show AuthFormFields;
import '../actions/auth_actions.dart' show RegisterRequestAction;

class _RegisterContainer extends StatelessWidget {
  final Map<String, FormFieldController> controllers;
  final OnFormSubmit handleSubmit;

  _RegisterContainer({this.controllers, this.handleSubmit});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => _RegisterContainerWithProps(
            registerRequestAction: vm.registerRequestAction,
            controllers: controllers,
            handleSubmit: handleSubmit,
          ));
}

class _RegisterContainerWithProps extends StatelessWidget {
  final Function registerRequestAction;
  final Map<String, FormFieldController> controllers;
  final OnFormSubmit handleSubmit;

  _RegisterContainerWithProps(
      {@required this.registerRequestAction,
      @required this.controllers,
      @required this.handleSubmit});

  void onFormSubmit() {
    final formValues = handleSubmit();

    if (formValues != null) {
      registerRequestAction(RegisterRequest(
          name: formValues["name"].value,
          email: formValues['email'].value,
          password: formValues['password'].value));
    }
  }

  @override
  Widget build(BuildContext context) => AuthForm(
        title: 'Sign in',
        subTitle: 'skyexpo matchmaking platform',
        switchLinkTitle: "Already have acount? Sign up.",
        swichLinkRoute: AppRoute.logIn,
        onFormSubmit: onFormSubmit,
        formWidget: AuthFormFields(
          controllers: this.controllers,
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

Widget createRegisterContainer(Map<String, FormFieldController> controllers,
        OnFormSubmit handleSubmit) =>
    _RegisterContainer(controllers: controllers, handleSubmit: handleSubmit);

final registerContainer = FormContainer(
    controllers: registerFormConfig, createChild: createRegisterContainer);
