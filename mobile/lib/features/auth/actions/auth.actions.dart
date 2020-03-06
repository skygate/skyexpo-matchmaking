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
  final String userData;

  LogInSucceedAction(this.userData);

  @override
  String toString() {
    return 'LogInSucceedAction{userData: $userData}';
  }
}

class LogInFailedAction {}
