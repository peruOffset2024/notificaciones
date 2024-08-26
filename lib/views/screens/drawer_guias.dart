import 'package:flutter/material.dart';

class GuiasScreen extends StatelessWidget {
  const GuiasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Mis Guías',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Función de búsqueda
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Guías Recientes',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _buildGuiasList(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Acción para añadir nueva guía
        },
        backgroundColor: Colors.greenAccent[400],
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  Widget _buildGuiasList() {
    return ListView.builder(
      itemCount: 10, // Número de guías
      itemBuilder: (context, index) {
        return Card(
          color: Colors.grey[900],
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.greenAccent[400],
              child: const Icon(Icons.description, color: Colors.black),
            ),
            title: Text(
              'Guía ${index + 1}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Descripción de la guía ${index + 1}',
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onTap: () {
              // Navegar a la vista de detalles de la guía
            },
          ),
        );
      },
    );
  }
}
