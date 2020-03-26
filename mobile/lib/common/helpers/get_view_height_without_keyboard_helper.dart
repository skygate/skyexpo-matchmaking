import 'package:flutter/widgets.dart';

getViewHeightWithoutKeyboard(context) =>
    MediaQuery.of(context).size.height -
    MediaQuery.of(context).viewInsets.bottom;
