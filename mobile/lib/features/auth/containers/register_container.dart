import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:mobile/store/app_state.dart' show AppState;
import '../widgets/log_in_form_widget.dart' show LogInForm;
import '../actions/auth_actions.dart' show RegisterRequestAction;

class RegisterContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) => LogInForm(
            onFormSubmit: vm.logInRequestAction,
          ));
}

class _ViewModel {
  final Function(dynamic) logInRequestAction;
  _ViewModel({@required this.logInRequestAction});

  static _ViewModel fromStore(Store<AppState> store) =>
      _ViewModel(logInRequestAction: (credentails) {
        store.dispatch(RegisterRequestAction(credentails));
      });
}
