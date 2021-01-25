import 'package:ewally/app.dart';
import 'package:ewally/configs/routes/routes.dart';
import 'package:ewally/configs/ui/Cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ewally/injection_container.dart' as injection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injection.init();
  Routes.createRoutes();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(statusBarColor: Cores.preto),
  );
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  runApp(EwallySelecao());
}
