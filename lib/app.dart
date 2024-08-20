import 'package:flutter/material.dart';
import 'package:push_notificaciones/screens/iniciar_sesion.dart';
import 'package:push_notificaciones/services/noti_push_firebase.dart';

//convertir a statefulwidget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //para mandar a otra ruta
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  // abrir un scaffold
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      new GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    PushNotificationsService.msjStream.listen((msj) {
      // ignore: avoid_print
      print('LLrgo este mensaje: $msj');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notificaciones push',
        initialRoute: '/home',
        routes: {
          '/home': (_) => const IniciarSesion(),
          //'/mensaje': (_) => const NavegadorIndex(),
        });
  }
}
