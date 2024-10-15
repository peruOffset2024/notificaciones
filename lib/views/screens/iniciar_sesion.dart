import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:push_notificaciones/providers/auth_provider.dart';
import 'package:push_notificaciones/providers/conexion_internet_provider.dart';
import 'package:push_notificaciones/views/screens/navegador.dart';
import 'package:push_notificaciones/views/screens/indicador_carga.dart';

class IniciarSesion extends StatefulWidget {
  const IniciarSesion({super.key});

  @override
  State<IniciarSesion> createState() => _IniciarSesionState();
}

class _IniciarSesionState extends State<IniciarSesion> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _alertUser() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Error al Identificarse',
            style: TextStyle(color: Colors.blue),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Ingrese un DNI válido'),
              const SizedBox(width: 20),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(size: 30, color: Colors.blue, Icons.cancel_rounded),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final conectInternet = context.watch<ConnectivityProvider>().isConnected;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 255, 255, 255), Color.fromARGB(255, 255, 255, 255)],
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
                  const Image(
                    height: 100,
                    width: 100,
                    image: AssetImage('assets/cogu_logo.png'),
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'C',
                                style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'O',
                                style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'G',
                                style: TextStyle(color: Colors.orange, fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: 'U',
                                style: TextStyle(color: Colors.orange, fontSize: 40, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        const Text('V 2.0',style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                  
                 
                  SizedBox(height: size.height * 0.05),

                  // Campo de Usuario
                  Form(
                    key: _formkey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: TextFormField(
                      maxLength: 15,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
                      keyboardType: TextInputType.number,
                      controller: _usernameController,
                      style: const TextStyle(color: Colors.black),
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person, color: Colors.grey, size: 22),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.orange),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.orange),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Colors.orange),
                        ),
                        labelText: 'DNI / C.I',
                        labelStyle: const TextStyle(color: Colors.grey, fontSize: 13),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

                  // Botón de Ingresar con indicador de carga
                  Consumer<Authprovider>(
                    builder: (context, authprovider, child) {
                      return authprovider.isLoading
                          ? const Center(child: IndicadorDeCarga()) // Indicador de carga
                          : ElevatedButton(
                              onPressed: () async {
                                if (_formkey.currentState?.validate() ?? false) {
                                  try {
                                    await authprovider.login(_usernameController.text);
                                    if (authprovider.authenticated) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NavegadorIndex(usuario: _usernameController.text),
                                        ),
                                      );
                                      _usernameController.clear();
                                    } else {
                                      conectInternet
                                          ? _alertUser()
                                          : ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('No tienes Conexión a internet')),
                                            );
                                    }
                                  } catch (e) {
                                    conectInternet
                                        ? _alertUser()
                                        : ScaffoldMessenger.of(context).showSnackBar(
                                            const SnackBar(content: Text('No tienes Conexión a internet')),
                                          );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: size.height * 0.010),
                                backgroundColor: Colors.orange,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'INGRESAR',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            );
                    },
                  ),
                  SizedBox(height: size.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
     floatingActionButton: Text(
                        '© Copyrigth 2024 COGU - T.I',
                        style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                      ),
    );
  }
}
