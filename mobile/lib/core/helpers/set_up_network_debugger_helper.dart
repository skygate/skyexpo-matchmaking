import 'package:flutter_flipperkit/flutter_flipperkit.dart';

setUpNetworkDebugger() {
  FlipperClient flipperClient = FlipperClient.getDefault();

  flipperClient.addPlugin(FlipperNetworkPlugin(
    useHttpOverrides: false,
  ));
  flipperClient.start();
}
