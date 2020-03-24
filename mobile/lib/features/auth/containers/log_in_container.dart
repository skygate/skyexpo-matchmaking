import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mobile/features/auth/widgets/log_in_widget.dart' show LogInForm;
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'package:mobile/features/auth/actions/auth_actions.dart'
    show LogInRequestAction;
import 'package:mobile/store/app_state.dart' show AppState;
import 'package:mobile/features/auth/models/credentails_model.dart'
    show Credentials;

class LogInContainer extends StatefulWidget {
  LogInContainer({Key key, this.setFormFieldValue, this.credentials})
      : super(key: key);
  final setFormFieldValue;
  final credentials;

  @override
  _LogInContainerState createState() => new _LogInContainerState();

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        void onFormSubmit() {
          print('odpalalm');
          print(credentials['email']);
          vm.logInRequestAction(credentials);
        }

        return LogInForm(
          onFormSubmit: onFormSubmit,
          setFormFieldValue: setFormFieldValue,
        );
      },
    );
  }
}

class _LogInContainerState extends State<LogInContainer> {
  final _credentials = {"email": '', "password": ''};

  @override
  void initState() {
    super.initState();
  }

  void setFormFieldValue({String name, String value}) {
    setState(() {
      _credentials[name] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new LogInContainer(
      setFormFieldValue: setFormFieldValue,
      credentials: _credentials,
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
