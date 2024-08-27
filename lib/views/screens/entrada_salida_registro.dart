import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/asistencia_provider.dart';


class RegistroAsistencia extends StatelessWidget {
  final TextEditingController _comentariosController = TextEditingController();

  // Datos del usuario simulados
  final Map<String, String> _userData = {
    "Nombre": "Eddy Ricardo \n Monago del Aguila",
    "Puesto": "Desarrollador de Software",
    "Departamento": "TI",
    "Foto": "https://scontent.flim23-1.fna.fbcdn.net/v/t1.18169-9/18698096_10203319177977549_1786612228346692954_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=53a332&_nc_ohc=rLPZeELVB64Q7kNvgEDO-mg&_nc_ht=scontent.flim23-1.fna&oh=00_AYCj_bKNojDBbubXZmbyONRM9rbsHP92QHmjOJOmPQ2zDw&oe=66F3812E", // Reemplaza con la URL de la foto real
  };

  RegistroAsistencia({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isPortrait = size.height > size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Registro de Asistencia', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isPortrait
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildUserCard(size),
                    const SizedBox(height: 20),
                    _buildRegistroForm(size, context),
                    const SizedBox(height: 20),
                  ],
                )
              : Row(
                  children: [
                    Expanded(child: _buildUserCard(size)),
                    const SizedBox(width: 20),
                    Expanded(child: _buildRegistroForm(size, context)),
                  ],
                ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildRegistroForm(Size size, BuildContext context) {
    return Card(
      color: Colors.blue[100],
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _comentariosController,
              decoration: InputDecoration(
                labelText: 'Comentarios (Opcional)',
                prefixIcon: const Icon(Icons.comment, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                labelStyle: const TextStyle(color: Colors.white),
                fillColor: Colors.grey[800],
                filled: true,
              ),
              style: const TextStyle(color: Colors.white),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Acción para registrar inicio
                      Provider.of<AsistenciaProvider>(context, listen: false).agregarAsistencia(
                        _userData["Nombre"]!,
                        "09:00 AM",
                        "05:00 PM",
                        "8h",
                      );
                    },
                    icon: const Icon(Icons.login, color: Colors.white),
                    label: const Text('Registrar Inicio', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Acción para registrar salida
                      Provider.of<AsistenciaProvider>(context, listen: false).agregarAsistencia(
                        _userData["Nombre"]!,
                        "09:00 AM",
                        "05:00 PM",
                        "8h",
                      );
                    },
                    icon: const Icon(Icons.logout, color: Colors.white),
                    label: const Text('Registrar Salida', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildUserCard(Size size) {
  return Card(
    color: Colors.blue[100],
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Foto de perfil
          CircleAvatar(
            radius: size.width * 0.1,
            backgroundImage: NetworkImage(_userData["Foto"]!),
          ),
          const SizedBox(width: 16),
          // Información del usuario
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userData["Nombre"]!,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'DNI: ${_userData["Puesto"]!}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'PLACA: ${_userData["Departamento"]!}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

}
