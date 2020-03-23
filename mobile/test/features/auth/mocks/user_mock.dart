import 'package:mobile/features/auth/models/credentails.model.dart'
    show Credentials;
import 'package:mobile/features/auth/models/user.model.dart' show User;

final userMock =
    User(id: "SDF", email: "test@email", name: "username", token: "token");

final credentailsMock = Credentials(email: 'dupa', password: 'dupa');

const userResponseMock =
    '{"id":"SDF","email":"test@email","name":"username","token":"token"}';
