import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';


class MessageScreen extends StatelessWidget {
  

  const MessageScreen({
    super.key,
    
  });

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<Authprovider>().conductor;
    final argts = ModalRoute.of(context)?.settings.arguments ?? 'No msj';
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Información de la reunión
              Text(
                'De: ',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                'Enviado el: ',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 8),
              Text(
                'Para: $usuario',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const Divider(height: 24, thickness: 2),
              const Text(
                'Asunto:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Lista de participantes
              Container(
                      height: size.height * 0.4,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.blue[50]
                      ),
                      child: ListTile(
                        // title: Text('aa'),
                         subtitle: Text('$argts'),
                        //leading: Text('CONTENIDO DEL MENSAJE'),
                       
                      ),
                    ),
              
              
              
            ],
          ),
        ),
      ),
    );
  }
}