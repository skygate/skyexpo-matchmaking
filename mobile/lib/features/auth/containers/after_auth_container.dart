import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:mobile/features/auth/actions/auth_actions.dart'
    show LogInRequestAction;
import 'package:mobile/features/auth/selectors/auth_selectors.dart'
    show getUserEmailSelector;
import 'package:mobile/features/auth/widgets/after_auth_widget.dart'
    show AfterAuth;
import 'package:mobile/store/app_state.dart' show AppState;

class AfterAuthContainer extends StatelessWidget {
  AfterAuthContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return AfterAuth(
          email: vm.email,
        );
      },
    );
  }
}

class _ViewModel {
  final Function(dynamic) logInRequestAction;
  final String email;
  _ViewModel({@required this.logInRequestAction, @required this.email});

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      logInRequestAction: (credentails) {
        store.dispatch(LogInRequestAction(credentails));
      },
      email: getUserEmailSelector(store.state),
    );
  }
}
