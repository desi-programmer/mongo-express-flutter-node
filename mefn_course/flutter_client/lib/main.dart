import 'package:flutter/material.dart';
import 'package:flutter_client/pages/bookings.dart';
import 'package:flutter_client/pages/home.dart';
import 'package:flutter_client/pages/login_ui.dart';
import 'package:flutter_client/pages/profile.dart';
import 'package:flutter_client/pages/register_ui.dart';
import 'package:flutter_client/pages/sanitization.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  setPathUrlStrategy();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _routedelegate = VxNavigator(
    notFoundPage: (uri, params) => MaterialPage(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Image.network(
            "https://media.tenor.com/images/00e83ff5a523055faed12d8b0c46cf02/tenor.gif",
          ),
        ),
      ),
    ),
    routes: {
      '/': (uri, params) => MaterialPage(
            child: HomePage(),
          ),
      '/login': (uri, params) => MaterialPage(
            child: LoginUi(uri.queryParameters['msg']),
          ),
      '/register': (uri, params) => MaterialPage(
            child: RegisterUi(),
          ),
      '/profile': (uri, params) => MaterialPage(
            child: UserProfile(),
          ),
      '/bookings': (uri, params) => MaterialPage(
            child: Bookings(),
          ),
      '/sanitization': (uri, params) => MaterialPage(
            child: SanitizationService(),
          ),
    },
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Rural Clap',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        fontFamily: "source",
      ),
      routeInformationParser: VxInformationParser(),
      routerDelegate: _routedelegate,
    );
  }
}
