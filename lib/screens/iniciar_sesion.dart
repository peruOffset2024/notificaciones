import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/screens/navegador.dart';


class IniciarSesion extends StatelessWidget {
  const IniciarSesion({super.key});

  @override
  Widget build(BuildContext context) {
    // Obtener el tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    final TextEditingController _username = TextEditingController();
    

    return Scaffold(
      body: Container(
        // Fondo con degradado
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
            Color.fromARGB(255, 127, 148, 151), 
            Color.fromARGB(255, 204, 219, 221)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1), // Ajuste del padding según el ancho de la pantalla
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Título
                Text(
                  'AQN1',
                  style: TextStyle(
                    fontSize: size.width * 0.1, // Tamaño de fuente responsivo
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF333333),
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: size.height * 0.05), // Espaciado responsivo

                // Campo de Usuario
                SizedBox(
                  height: size.height * 0.08, // Altura responsiva
                  child: TextFormField(
                    controller: _username,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person, color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      labelText: 'Usuario',
                      hintText: '@gmail.com',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                    ),
                    onChanged: (value) {
                      context.read<Authprovider>().authentication(value) ;
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.03), // Espaciado responsivo

                // Campo de Contraseña
                SizedBox(
                  height: size.height * 0.08, // Altura responsiva
                  child: TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock, color: Colors.teal),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      labelText: 'Contraseña',
                      hintText: '*******',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.05), // Espaciado responsivo

                // Botón de Ingresar
                ElevatedButton(
                  onPressed: () {
                    context.read<Authprovider>().authentication(_username.text);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  NavegadorIndex(usuario: _username.text,)),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.025), // Padding responsivo
                    backgroundColor: const Color.fromARGB(255, 0, 7, 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                  ),
                  child: Text(
                    'Ingresar',
                    style: TextStyle(
                      fontSize: size.width * 0.05, // Tamaño de fuente responsivo
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
