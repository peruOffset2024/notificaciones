import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsService {
  static FirebaseMessaging mensaje = FirebaseMessaging.instance;
  static String? token;

//Implementamos el sistema para recibir el flujo del mensaje
  // ignore: prefer_final_fields
  static StreamController<String> _msjStream =  StreamController.broadcast();
  static Stream<String> get msjStream => _msjStream.stream;

  
  static Future backgroundHandler(RemoteMessage mensaje) async{
    // ignore: avoid_print
    print('App en Background: ${mensaje.messageId}');
    //Aca el _msjStream podria cambiar de estado
    _msjStream.add(mensaje.notification?.title ?? 'No tiene titulo');
  }

  static Future foregroundHandler(RemoteMessage mensaje) async {
    // ignore: avoid_print
    print('App en Foreground: ${mensaje.messageId}');
    _msjStream.add(mensaje.notification?.title ?? 'No tiene titulo');
  } 

  static Future openAppHandler(RemoteMessage mensaje) async {
    // ignore: avoid_print
    print('Abriendo appp desde background: ${mensaje.messageId}');
    _msjStream.add(mensaje.notification?.title ?? 'No tiene titulo');
  } 
  
  static cargarFirebaseApp() async{
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    // ignore: avoid_print
    print('Recibiendo el token $token');

    //Implementamos los manejadores (handlers) para que recibean las notif
    FirebaseMessaging.onBackgroundMessage(backgroundHandler);
    FirebaseMessaging.onMessage.listen(foregroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(openAppHandler);
  }

  static closeStream(){
    _msjStream.close();
  }
  
}