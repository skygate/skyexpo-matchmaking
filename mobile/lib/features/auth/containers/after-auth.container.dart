import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile/features/auth/selectors/auth.selectors.dart';
import 'package:mobile/features/auth/widgets/after-auth.widget.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:mobile/features/auth/actions/auth.actions.dart';
import 'package:mobile/store/app_state.dart';

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
