import 'package:flutter/material.dart';

import 'config/routes_config.dart' show AppRoute, BottomNavigationRoute;
import 'core/widgets/bottom_navigation_layout_widget.dart'
    show BottomNavigationLayout;

import 'features/auth/containers/log_in_container.dart' show LogInContainer;
import 'features/auth/containers/register_container.dart'
    show RegisterContainer;
import 'features/matching/containers/matching_list_container.dart'
    show MatchingListContainer;
import 'features/profile_form/containers/profile_form_container.dart'
    show profileFormContainer;

final appRoutes = {
  AppRoute.logIn.value: (context) => LogInContainer(),
  AppRoute.register.value: (context) => RegisterContainer(),
  AppRoute.profileForm.value: (context) => profileFormContainer,
  AppRoute.bottomNavigation.value: (context) => BottomNavigationLayout(),
};

// This is for nested routing made with tabs
final bottomNavigationRoutes = {
  BottomNavigationRoute.matchingList.value: MatchingListContainer(),
  BottomNavigationRoute.calendar.value: MatchingListContainer(),
  BottomNavigationRoute.notifications.value: MatchingListContainer(),
  BottomNavigationRoute.settings.value: MatchingListContainer(),
};

final List<Widget> bottomNavigationTabsBodyList =
    bottomNavigationRoutes.values.toList();
