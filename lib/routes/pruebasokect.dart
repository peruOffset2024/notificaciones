/*import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RatchetSocketExample extends StatefulWidget {
  @override
  _RatchetSocketExampleState createState() => _RatchetSocketExampleState();
}

class _RatchetSocketExampleState extends State<RatchetSocketExample> {
  final WebSocketChannel channel = WebSocketChannel.connect(
    Uri.parse('ws://192.168.1.90:8080/pruebasocket'),
  );

  final TextEditingController controller = TextEditingController();
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    channel.stream.listen((data) {
      setState(() {
        messages.add(data);
      });
    });
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Conexión a Ratchet')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(labelText: 'Enviar mensaje'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    channel.sink.add(controller.text);
                    controller.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/
