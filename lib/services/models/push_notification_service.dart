import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


//se requiere que desde aqui nos escuche my app
class PushNotificationService {
  //envia eventos e informacion a otros widget, canal por donde 
  //broadcast mas de un widget suscriba y (escuche las notificaiones)
  //crear una variable para mandar la informacion
  // ignore: prefer_final_fields
  static StreamController<String> _msjStream =   StreamController.broadcast();

  static FirebaseMessaging  messaging = FirebaseMessaging.instance;
  // si cada dispositivo que descargue nuestra aplicacion  debe tener un token 
  // una cadena que contiene informacion codificada cuadno se decodifica se puede acceder a esa informacion

  static Stream<String> get messagesStream => _msjStream.stream;


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
    // ignore: avoid_print
    print('Estado BACKGROUND segundo plano');
    _msjStream.add(mjs.notification?.body ?? 'No body');
    // ignore: avoid_print
    print('Mensaje Titulo: ${mjs.notification?.title}');
    // ignore: avoid_print
    print('Mensaje Titulo: ${mjs.notification?.body}');
    
  }

  static Future _onMsjController(RemoteMessage mjs) async {
    // ignore: avoid_print
    print('Estado FOREGROUND  abierta');
    //print('Mensaje de la notificacion: ${mjs.messageId}');
    // ignore: avoid_print
    print('Mensaje Titulo: ${mjs.notification?.title}');
    // ignore: avoid_print
    print('Mensaje Titulo: ${mjs.notification?.body}');
    
    _msjStream.add(mjs.notification?.title ?? 'No title');
    _msjStream.add(mjs.data['usuario'] ?? 'No hay datos o personalizados');
    // ignore: avoid_print
    print('MENSAJE DATOS-DATA datos adicionales: ${mjs.data}');

    

  }
  // cuadno el estado esta cerrado tenemos que hacer para que inicie
  // tenemos que hacer que actualize el estado mediante my app y automaticamente lo mande
  static Future _onMsjOpenApp(RemoteMessage mjs) async{
    // ignore: avoid_print
    print('Estado OPEN APP  cerrada');
    _msjStream.add(mjs.notification?.body ?? 'No body');
    // ignore: avoid_print
    print('Mensaje Titulo: ${mjs.notification?.title}');
    // ignore: avoid_print
    print('Mensaje Titulo: ${mjs.notification?.body}');
  }

  static closeStreams(){
    _msjStream.close();
  }

}