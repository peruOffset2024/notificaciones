import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/views/screens/navegador.dart';

class IniciarSesion extends StatefulWidget {
  const IniciarSesion({super.key});

  @override
  _IniciarSesionState createState() => _IniciarSesionState();
}

class _IniciarSesionState extends State<IniciarSesion> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obcureText = true;
  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _passwordVisibility(){
    setState(() {
      _obcureText = !_obcureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 3, 32, 14), Color(0xFF121212)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo y Título
                  Center(
                    child: RichText(
                      text: const TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: 'A',
                            style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'Q',
                            style: TextStyle(color: Colors.green, fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'N',
                            style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'Q',
                            style: TextStyle(color: Colors.green, fontSize: 40, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
              
                  SizedBox(height: size.height * 0.05),
              
                  // Campo de Usuario
                  SizedBox(
                    height: size.height * 0.08,
                    child: TextFormField(
                      controller: _usernameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.person, color: Color(0xFF1DB954)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF1DB954)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF1DB954)),
                        ),
                        labelText: 'Correo Electrónico o Usuario',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: 'ejemplo@correo.com',
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.6)),
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.7),
                      ),
                      onChanged: (value) {
                        // Aquí podrías actualizar el estado global si es necesario
                        context.read<Authprovider>().authentication(value);
                      },
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
              
                  // Campo de Contraseña
                  SizedBox(
                    height: size.height * 0.08,
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obcureText,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        prefixIcon:
                            const Icon(Icons.lock, color: Color(0xFF1DB954)),
                        suffixIcon: IconButton(onPressed: _passwordVisibility, icon: Icon(
                          _obcureText ? Icons.visibility_off :
                          Icons.visibility)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF1DB954)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xFF1DB954)),
                        ),
                        labelText: 'Contraseña',
                        labelStyle: const TextStyle(color: Colors.white),
                        hintText: '*******',
                        hintStyle:
                            TextStyle(color: Colors.white.withOpacity(0.6)),
                        filled: true,
                        fillColor: Colors.black.withOpacity(0.7),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
              
                  // Botón de Ingresar
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<Authprovider>()
                          .authentication(_usernameController.text);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              NavegadorIndex(usuario: _usernameController.text),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                      backgroundColor: const Color(0xFF1DB954),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Ingresar',
                      style: TextStyle(
                        fontSize: size.width * 0.05,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
              
                  // Enlace para Olvidé mi contraseña
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        // Lógica para restablecer la contraseña
                      },
                      child: const Text(
                        'Olvidé mi contraseña',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
              
                  // Enlace para Crear una cuenta
                  Align(
                    alignment: Alignment.center,
                    child: TextButton(
                      onPressed: () {
                        // Navegar a la pantalla de registro
                      },
                      child: const Text(
                        'Crear una cuenta',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejemplo de TextSpan'),
      ),
      body: Center(
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: 'A',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              TextSpan(
                text: 'Q',
                style: TextStyle(color: Colors.black, fontSize: 40),
              ),
              TextSpan(
                text: 'N',
                style: TextStyle(color: Colors.white, fontSize: 40),
              ),
              TextSpan(
                text: 'Q',
                style: TextStyle(color: Colors.black, fontSize: 40),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CustomText(),
  ));
}
