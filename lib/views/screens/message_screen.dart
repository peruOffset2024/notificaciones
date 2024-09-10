import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';


class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usuario = context.watch<Authprovider>().conductor;
    final argts = ModalRoute.of(context)?.settings.arguments ?? 'No msj';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      body: Container(
        decoration:  BoxDecoration(
          border: Border.all()
        ),
        child: Card(
          child: Padding(padding: const EdgeInsets.all(8),
          child: ListTile(
            title: Text(usuario),
            subtitle: Text('aqui: $argts'),
          ),
          ),
        ),
      ) ,
    );
  }
}