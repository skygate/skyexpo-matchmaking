import 'package:flutter/material.dart';
import 'package:mobile/config/index.dart' show AppRoute;
import 'package:redux/redux.dart' show Store;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;

import 'package:mobile/store/app_state.dart' show AppState;
import 'package:mobile/features/form/containers/form_container.dart'
    show FormContainer;
import 'package:mobile/features/form/models/form_field_controller_model.dart'
    show FormFieldController;
import 'package:mobile/features/form/models/on_form_submit_type.dart'
    show OnFormSubmit;
import '../configs/log_in_form_config.dart' show logInFormConfig;
import 'package:union/union.dart';
import '../models/index.dart' show Credentials;
import '../widgets/auth_form_widget.dart' show AuthForm;
import '../widgets/auth_form_fields_widget.dart' show AuthFormFields;
import '../actions/auth_actions.dart' show LogInRequestAction;

class _LogInContainer extends StatelessWidget {
  final Map<String, FormFieldController> controllers;
  final OnFormSubmit handleSubmit;

  _LogInContainer({this.controllers, this.handleSubmit});

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => _LogInContainerWithProps(
            logInRequestAction: vm.logInRequestAction,
            controllers: controllers,
            handleSubmit: handleSubmit,
          ));
}

class _LogInContainerWithProps extends StatelessWidget {
  final Function logInRequestAction;
  final Map<String, FormFieldController> controllers;
  final OnFormSubmit handleSubmit;

  _LogInContainerWithProps(
      {@required this.logInRequestAction,
      @required this.controllers,
      @required this.handleSubmit});

  void onFormSubmit() {
    final formValues = handleSubmit();

    if (formValues != null) {
      logInRequestAction(Credentials(
          email: formValues['email'].value,
          password: formValues['password'].value));
    }
  }

  @override
  Widget build(BuildContext context) => AuthForm(
        title: 'Sign up',
        subTitle: 'skyexpo matchmaking platform',
        switchLinkTitle: "Don't have account? Sign in.",
        swichLinkRoute: AppRoute.register,
        onFormSubmit: onFormSubmit,
        formWidget: AuthFormFields(
          controllers: this.controllers,
          isRegisterForm: false,
        ),
      );
}

class _ViewModel {
  final Function(dynamic) logInRequestAction;
  _ViewModel({@required this.logInRequestAction});

  static _ViewModel fromStore(Store<AppState> store) =>
      _ViewModel(logInRequestAction: (credentails) {
        store.dispatch(LogInRequestAction(credentails));
      });
}

Widget createLogInContainer(controllers, OnFormSubmit handleSubmit) =>
    _LogInContainer(controllers: controllers, handleSubmit: handleSubmit);

final logInContainer = FormContainer(
    controllers: logInFormConfig, createChild: createLogInContainer);
