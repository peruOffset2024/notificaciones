import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

//se requiere que desde aqui nos escuche my app
class PushNotificationService {
  //envia eventos e informacion a otros widget, canal por donde 
  //broadcast mas de un widget suscriba y (escuche las notificaiones)
  //crear una variable para mandar la informacion
  static StreamController<String> _msjStream = new  StreamController.broadcast();

  static FirebaseMessaging  messaging = FirebaseMessaging.instance;
  // si cada dispositivo que descargue nuestra aplicacion  debe tener un token 
  // una cadena que contiene informacion codificada cuadno se decodifica se puede acceder a esa informacion

  static String? token;

  static Future<void> initApp() async {
   await Firebase.initializeApp();
   token = await FirebaseMessaging.instance.getToken();
   // ignore: avoid_print
   print('Token Firebase; $token ');

   FirebaseMessaging.onBackgroundMessage(__backgroundController);
   FirebaseMessaging.onMessage.listen(_onMsjController);
   FirebaseMessaging.onMessageOpenedApp.listen(_onMsjOpenApp);
  }

  // puede detectar si nuestra aplicacion est en backgound
  static Future __backgroundController(RemoteMessage mjs) async {
    print('Estado BACKGROUND segundo plano');
    
  }

  static Future _onMsjController(RemoteMessage mjs) async {
    print('Estado FOREGROUND  abierta');
    //print('Mensaje de la notificacion: ${mjs.messageId}');
    print('Mensaje Titulo: ${mjs.notification?.title}');
    _msjStream.add(mjs.notification?.title ?? 'No title');

  }

  static Future _onMsjOpenApp(RemoteMessage mjs) async{
    print('Estado OPEN APP  cerrada');
  }

  static closeStreams(){
    _msjStream.close();
  }

}