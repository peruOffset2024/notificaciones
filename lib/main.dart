import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/app.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/buscador_provider.dart';
import 'package:push_notificaciones/providers/pokemon_provider.dart';
import 'package:push_notificaciones/providers/rutas_provider.dart';
import 'package:push_notificaciones/services/models/push_notification_service.dart';





void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // los plugins usan widgets - crear unos widgets
  await PushNotificationService.initApp();
  //await PushNotificationsService.cargarFirebaseApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_)=> Authprovider()), 
    ChangeNotifierProvider(create: (_)=> BuscadorProvider()), 
    ChangeNotifierProvider(create: (_)=> PokemonProvider()), 
    ChangeNotifierProvider(create: (_)=> RutasProvider()),
  ],
  child: const MyApp()));
}





