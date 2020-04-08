import 'package:flutter/material.dart';
import 'package:mobile/config/index.dart' show AppRoute;
import 'package:redux/redux.dart' show Store;
import 'package:flutter_redux/flutter_redux.dart' show StoreConnector;

import 'package:mobile/store/app_state.dart' show AppState;
import '../models/index.dart' show Credentials;
import '../widgets/auth_form_widget.dart' show AuthForm;
import '../widgets/auth_form_fields_widget.dart' show AuthFormFields;
import '../actions/auth_actions.dart' show LogInRequestAction;

class LogInContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => _LogInContainerWithStateAndProps(
            logInRequestAction: vm.logInRequestAction,
          ));
}

class _LogInContainerWithStateAndProps extends StatefulWidget {
  final Function logInRequestAction;
  _LogInContainerWithStateAndProps({@required this.logInRequestAction});

  @override
  _LogInContainerState createState() => _LogInContainerState();
}

class _LogInContainerState extends State<_LogInContainerWithStateAndProps> {
  final formKey = GlobalKey<FormState>();
  Map<String, String> loginFormData;

  @override
  void initState() {
    super.initState();
    loginFormData = {'email': '', 'password': ''};
  }

  void setFormFieldValue(String fieldId, String value) => setState(() {
        loginFormData[fieldId] = value;
      });

  void submitForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();

      widget.logInRequestAction(Credentials(
          email: loginFormData['email'], password: loginFormData['password']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthForm(
      title: 'Sign up',
      subTitle: 'skyexpo matchmaking platform',
      switchLinkTitle: "Don't have account? Sign in.",
      swichLinkRoute: AppRoute.register,
      onFormSubmit: submitForm,
      formWidget: AuthFormFields(
        formKey: formKey,
        setFormFieldValue: setFormFieldValue,
        formData: loginFormData,
        isRegisterForm: false,
      ),
    );
  }
}

class _ViewModel {
  final Function(dynamic) logInRequestAction;
  _ViewModel({@required this.logInRequestAction});

  static _ViewModel fromStore(Store<AppState> store) =>
      _ViewModel(logInRequestAction: (credentails) {
        store.dispatch(LogInRequestAction(credentails));
      });
}
