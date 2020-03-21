import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile/features/auth/widgets/log-in.widget.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:mobile/features/auth/actions/auth.actions.dart';
import 'package:mobile/store/app_state.dart';

class LogInContainer extends StatelessWidget {
  LogInContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return LogInForm(
          title: 'Log in',
          onFormSubmit: vm.logInRequestAction,
        );
      },
    );
  }
}

class _ViewModel {
  final Function(dynamic) logInRequestAction;
  _ViewModel({@required this.logInRequestAction});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(logInRequestAction: (credentails) {
      store.dispatch(LogInRequestAction(credentails));
    });
  }
}
