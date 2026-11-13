import 'package:flutter/material.dart';
import '../../widgets/custom_app_bar.dart';

class ExamsScreen extends StatelessWidget {
  const ExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Meus Exames'),
      body: const Center(
        child: Text('Linha do tempo de exames e arquivos aqui.'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add_a_photo),
        label: const Text('Novo Exame'),
      ),
    );
  }
}