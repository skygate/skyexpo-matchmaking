import 'package:flutter/material.dart';

/* In flutter only statefulWidget can triger request on init (componentDidMout in react)
which is uncomfortable. This widget is a helper/wrapper that get child and also function
to triger on init */

class OnInitWrapper extends StatefulWidget {
  final Function onInit;
  final Widget child;

  const OnInitWrapper({@required this.onInit, @required this.child});

  @override
  _OnInitWrapperState createState() => _OnInitWrapperState();
}

class _OnInitWrapperState extends State<OnInitWrapper> {
  @override
  void initState() {
    if (widget.onInit != null) {
      widget.onInit();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
