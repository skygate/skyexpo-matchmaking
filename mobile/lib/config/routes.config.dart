import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

const routes = {
  "home": "/",
  "logIn": "log-in",
  "afterAuth": 'after-auth',
  "matchingList": 'matching-list'
};
