import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final argts = ModalRoute.of(context)?.settings.arguments ?? 'No msj';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Message'),
      ),
      body:  Center(child:  Text('SCREEN MENSAJE argumentos: $argts', style: const TextStyle(fontSize: 26),)),
    );
  }
}