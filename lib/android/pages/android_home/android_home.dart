import 'package:cardapio/android/pages/android_home/home_menu_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AndroidHome extends StatelessWidget {
  const AndroidHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha uma opção'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.navigate('/login/');
            },
            icon: const Icon(Icons.power_settings_new_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            HomeMenuTile(
              title: 'Cardápio da Semana',
              icon: Icons.menu_book,
              onTap: () {
                Modular.to.pushNamed('/week-menu');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            HomeMenuTile(
              title: 'Reserva de Pratos',
              icon: Icons.reorder,
              onTap: () {
                Modular.to.pushNamed('/order');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            HomeMenuTile(
              title: 'Pesquisa de Satisfação',
              icon: Icons.star_rate,
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            HomeMenuTile(
              title: 'Site',
              icon: Icons.link,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
