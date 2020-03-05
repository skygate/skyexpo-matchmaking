import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import 'features/auth/containers/log-in.container.dart';
import 'features/auth/reducers/auth.reducer.dart';
import 'package:mobile/store/app-state.dart';
import 'package:mobile/store/root-epic.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(Main());
}

class Main extends StatelessWidget {
  final Store<AppState> store;

  Main({
    Key key,
  })  : store = Store<AppState>(appReducer,
            initialState: new AppState(auth: new AuthState()),
            middleware: [epicMiddleware]),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider(
        store: store,
        child: MaterialApp(
          title: 'Sky raport generator',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: Scaffold(
            appBar: AppBar(title: Text('Sky raport generator')),
            body: Container(child: LogInContainer()),
          ),
        ));
  }
}
