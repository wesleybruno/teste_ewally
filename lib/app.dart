import 'package:ewally/configs/routes/routes.dart';
import 'package:ewally/configs/ui/Cores.dart';
import 'package:ewally/configs/ui/Fontes.dart';
import 'package:ewally/features/splash/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sailor/sailor.dart';

class EwallySelecao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EWally',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: Fontes.montserrat,
      ),
      onGenerateRoute: Routes.sailor.generator(),
      navigatorKey: Routes.sailor.navigatorKey,
      navigatorObservers: [
        SailorLoggingObserver(),
        Routes.sailor.navigationStackObserver,
      ],
      home: Scaffold(
        body: SplashScreen(),
        backgroundColor: Cores.cinza[50],
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [const Locale('pt')],
    );
  }
}
