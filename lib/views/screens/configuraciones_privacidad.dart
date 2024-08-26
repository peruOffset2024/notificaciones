import 'package:flutter/material.dart';

class ConfiguracionesPrivacidadScreen extends StatelessWidget {
  const ConfiguracionesPrivacidadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Configuraciones y Privacidad',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSectionTitle('Cuenta'),
          _buildConfigOption(
            context,
            icon: Icons.person_outline,
            title: 'Perfil',
            subtitle: 'Gestiona la información de tu cuenta',
            onTap: () {
              // Navegar a la pantalla de perfil
            },
          ),
          _buildConfigOption(
            context,
            icon: Icons.lock_outline,
            title: 'Contraseña',
            subtitle: 'Cambia tu contraseña',
            onTap: () {
              // Navegar a la pantalla de cambiar contraseña
            },
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('Preferencias'),
          _buildConfigOption(
            context,
            icon: Icons.notifications_outlined,
            title: 'Notificaciones',
            subtitle: 'Configura tus preferencias de notificación',
            onTap: () {
              // Navegar a la pantalla de notificaciones
            },
          ),
          _buildConfigOption(
            context,
            icon: Icons.language_outlined,
            title: 'Idioma',
            subtitle: 'Selecciona tu idioma preferido',
            onTap: () {
              // Navegar a la pantalla de selección de idioma
            },
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('Privacidad'),
          _buildConfigOption(
            context,
            icon: Icons.privacy_tip_outlined,
            title: 'Política de Privacidad',
            subtitle: 'Revisa nuestra política de privacidad',
            onTap: () {
              // Navegar a la pantalla de política de privacidad
            },
          ),
          _buildConfigOption(
            context,
            icon: Icons.security_outlined,
            title: 'Seguridad',
            subtitle: 'Configura la seguridad de tu cuenta',
            onTap: () {
              // Navegar a la pantalla de seguridad
            },
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('General'),
          _buildConfigOption(
            context,
            icon: Icons.help_outline,
            title: 'Ayuda',
            subtitle: 'Obtén ayuda y soporte',
            onTap: () {
              // Navegar a la pantalla de ayuda
            },
          ),
          _buildConfigOption(
            context,
            icon: Icons.info_outline,
            title: 'Acerca de',
            subtitle: 'Información sobre la aplicación',
            onTap: () {
              // Navegar a la pantalla de acerca de
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildConfigOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      color: Colors.grey[900],
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.greenAccent[400]),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: onTap,
      ),
    );
  }
}
