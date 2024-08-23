import 'package:flutter/material.dart';
import 'package:push_notificaciones/views/screens/iniciar_sesion.dart';
import 'package:push_notificaciones/views/screens/message_screen.dart';
import 'package:push_notificaciones/services/models/push_notification_service.dart';


//convertir a statefulwidget
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // permite ver la navegacion
  //para mandar a otra ruta
  final GlobalKey<NavigatorState> navigatorKey =
       GlobalKey<NavigatorState>();

  // abrir un scaffold
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
       GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

  

  PushNotificationService.messagesStream.listen((mensaje){
      print('------------------- > DESDE MYAPP mensaje: $mensaje');

    navigatorKey.currentState?.pushNamed('/mensaje', arguments: mensaje);

      final snackBar = 
        SnackBar(content: Text('Esto es snackbar msj: $mensaje'));
        scaffoldKey.currentState?.showSnackBar(snackBar);
    }
   );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notificaciones push',
        initialRoute: '/home',
        scaffoldMessengerKey: scaffoldKey,
        navigatorKey: navigatorKey,
        routes: {
          '/home': (_) => const IniciarSesion(),
          '/mensaje': (_) => const MessageScreen(),
        });
  }
}
