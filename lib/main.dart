import 'package:app_tpi/src/pages/home.dart';
import 'package:app_tpi/src/widgets/error404.dart';
import 'package:flutter/material.dart';
import 'package:app_tpi/src/routes/routes.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Skin check',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF6C8F23)),
        useMaterial3: true,
      ),
      routes: getApplicationRoutes(),
      initialRoute: '/login',
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const Error404()),
      navigatorObservers: [routeObserver],
    );
  }
}
