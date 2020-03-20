import 'package:flutter_flipperkit/flutter_flipperkit.dart';

setUpNetworkDebugger() {
  FlipperClient flipperClient = FlipperClient.getDefault();

  flipperClient.addPlugin(new FlipperNetworkPlugin(
    useHttpOverrides: false,
  ));
  flipperClient.start();
}
