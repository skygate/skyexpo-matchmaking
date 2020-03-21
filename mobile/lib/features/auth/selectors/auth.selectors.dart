import 'package:reselect/reselect.dart';

import 'package:mobile/features/auth/reducers/auth.reducer.dart';
import 'package:mobile/store/app_state.dart';

final getAuthStateSelector = (AppState state) => state.auth;

final getUserEmailSelector = createSelector1(
    getAuthStateSelector, (AuthState authState) => authState.email);
