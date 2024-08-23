import 'package:flutter/material.dart';

class RegistroSalida extends StatefulWidget {
  const RegistroSalida({
    super.key,
    required this.isActive,
    required this.label,
    required this.onChanged,
  });

  final bool isActive;
  final String label;
  final ValueChanged<bool> onChanged;

  @override
  State<RegistroSalida> createState() => _RegistroSalidaState();
}

final TextEditingController _lugarEntrega = TextEditingController();

class _RegistroSalidaState extends State<RegistroSalida> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Text(
          'T00-00001',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.green),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black
        ),
        child: Center(
          // Asegura que todo el contenido esté centrado
          child: SingleChildScrollView(
            child: Column(
              // Centra verticalmente
              children: [
                const SizedBox(height: 20),
                const Text(
                  'VIRU S.A',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(
                    height: 40), // Espaciado entre el texto y los switches
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centra horizontalmente
                  children: [
                    Column(
                      children: [
                        Switch(
                          value: widget.isActive,
                          onChanged: widget.onChanged,
                          activeColor: Colors.green, // Color del switch activo
                          inactiveThumbColor:
                              Colors.grey, // Color del switch inactivo
                          inactiveTrackColor:
                              Colors.grey[300], // Color de la pista inactiva
                        ),
                        const SizedBox(
                            height: 8), // Espaciado entre el switch y el texto
                        Text(
                          widget.label,
                          style: const TextStyle(
                            fontSize: 16, // Tamaño de la fuente
                            fontWeight: FontWeight.bold, // Grosor de la fuente
                            color: Colors.white, // Color del texto
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        width:
                            40), // Espaciado entre las dos columnas de switches
                    Column(
                      children: [
                        Switch(
                          value: widget.isActive,
                          onChanged: widget.onChanged,
                          activeColor: Colors.green, // Color del switch activo
                          inactiveThumbColor:
                              Colors.grey, // Color del switch inactivo
                          inactiveTrackColor:
                              Colors.grey[300], // Color de la pista inactiva
                        ),
                        const SizedBox(
                            height: 8), // Espaciado entre el switch y el texto
                        Text(
                          widget.label,
                          style: const TextStyle(
                            fontSize: 16, // Tamaño de la fuente
                            fontWeight: FontWeight.bold, // Grosor de la fuente
                            color: Colors.white, // Color del texto
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                    height: 40), // Espaciado entre las filas y el switch final
                Column(
                  children: [
                    Switch(
                      value: widget.isActive,
                      onChanged: widget.onChanged,
                      activeColor: Colors.green, // Color del switch activo
                      inactiveThumbColor:
                          Colors.grey, // Color del switch inactivo
                      inactiveTrackColor:
                          Colors.grey[300], // Color de la pista inactiva
                    ),
                    const SizedBox(
                        height: 8), // Espaciado entre el switch y el texto
                    Text(
                      widget.label,
                      style: const TextStyle(
                        fontSize: 16, // Tamaño de la fuente
                        fontWeight: FontWeight.bold, // Grosor de la fuente
                        color: Colors.white, // Color del texto
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Observaciones',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxHeight: 200),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              style: const TextStyle(color: Colors.black),
                              controller: _lugarEntrega,
                              maxLines: null,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  contentPadding: EdgeInsets.all(10),
                                  filled: true,
                                  fillColor: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        disabledColor: Colors.grey,
        onPressed: () {},
        color: Colors.green,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 50,
            vertical: 10,
          ),
          child: const Text(
            'Registrar Salida',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
