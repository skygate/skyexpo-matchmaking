import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:mobile/features/auth/actions/auth_actions.dart'
    show LogInRequestAction;
import 'package:mobile/store/app_state.dart' show AppState;
import '../widgets/log_in_widget.dart' show LogInForm;

class LogInContainer extends StatefulWidget {
  LogInContainer({Key key}) : super(key: key);
  @override
  _LogInContainerState createState() => new _LogInContainerState();
}

class _LogInContainerState extends State<LogInContainer> {
  _LogInContainerState({Key key, this.loginFormData});
  final Map<String, String> loginFormData;

  @override
  void initState() {
    super.initState();
  }

  void setFormFieldValue(String fieldId, String value) => setState(() {
        loginFormData[fieldId] = value;
      });

  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => _LogInContainerWithPropsAndState(
            logInRequestAction: vm.logInRequestAction,
            setFormFieldValue: setFormFieldValue,
          ));
}

class _LogInContainerWithPropsAndState extends StatelessWidget {
  final Function setFormFieldValue;
  final Function logInRequestAction;
  final Map<String, String> loginFormData;
  _LogInContainerWithPropsAndState(
      {this.setFormFieldValue, this.logInRequestAction, this.loginFormData});

  void onFormSubmit() {}

  @override
  Widget build(BuildContext context) => LogInForm(
      setFormFieldValue: setFormFieldValue, onFormSubmit: onFormSubmit);
}

class _ViewModel {
  final Function(dynamic) logInRequestAction;
  _ViewModel({@required this.logInRequestAction});

  static _ViewModel fromStore(Store<AppState> store) =>
      _ViewModel(logInRequestAction: (credentails) {
        store.dispatch(LogInRequestAction(credentails));
      });
}
