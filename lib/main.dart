import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/app.dart';
import 'package:push_notificaciones/providers/guias_salidar_provider.dart';
import 'package:push_notificaciones/providers/asistencia_provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/guia_x_cliente_provider.dart';
import 'package:push_notificaciones/providers/image_provider.dart';
import 'package:push_notificaciones/providers/lista_guias_provider.dart';
import 'package:push_notificaciones/providers/location_provider.dart';
import 'package:push_notificaciones/providers/pedido_provider.dart';
import 'package:push_notificaciones/providers/reg_sal_switch_provider.dart';
import 'package:push_notificaciones/providers/rutas_provider.dart';
import 'package:push_notificaciones/providers/seguimiento_estado_provider.dart';
import 'package:push_notificaciones/providers/track_provider.dart';
import 'package:push_notificaciones/providers/tracking_provider.dart';
import 'package:push_notificaciones/services/models/push_notification_service.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // los plugins usan widgets - crear unos widgets
  await PushNotificationService.initApp();
  //await PushNotificationsService.cargarFirebaseApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => RutasProvider()),
    ChangeNotifierProvider(create: (_) => Authprovider()),
    ChangeNotifierProvider(create: (_) => TrackingProvider()),
    ChangeNotifierProvider(create: (_) => LocationProvider()), 
    ChangeNotifierProvider(create: (_) => GuiasSalidasProvider()), 
    ChangeNotifierProvider(create: (_) => SwitchStateProvider()),
    ChangeNotifierProvider(create: (_) => PedidoProvider()), 
    ChangeNotifierProvider(create: (_) => AsistenciaProvider()), 
    ChangeNotifierProvider(create: (_) => ListaGuiaProvider()), 
    ChangeNotifierProvider(create: (_) => GuiaxClienteProvider()), 
    ChangeNotifierProvider(create: (_) => SeguimientoEstadoProvider()), 
    ChangeNotifierProvider(create: (_) => TrackProviderSegui()), 
    ChangeNotifierProvider(create: (_) => ImagenesProvider()),

  ], child: const MyApp()));
}

