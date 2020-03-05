import 'package:mobile/features/auth/models/credentails.model.dart';

class LogInRequestAction {
  final Credentials credentials;

  LogInRequestAction(this.credentials);

  @override
  String toString() {
    return 'LogInRequestAction{credentials: $credentials}';
  }
}

class LogInSucceedAction {
  final Credentials userData;

  LogInSucceedAction(this.userData);

  @override
  String toString() {
    return 'LogInRequestAction{userData: $userData}';
  }
}

class LogInFailedAction {}
