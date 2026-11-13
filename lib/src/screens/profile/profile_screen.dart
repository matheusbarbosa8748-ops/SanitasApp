import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Perfil e Saúde'),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          ListTile(
            leading: Icon(Icons.person, size: 32),
            title: Text('Nome do Usuário', style: TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text('Tipo Sanguíneo: O+ | Alergias: Nenhuma'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.family_restroom, size: 32),
            title: Text('Familiares / Cuidadores Vinculados'),
            subtitle: Text('Nenhum familiar conectado.'),
          ),
        ],
      ),
    );
  }
}