import 'package:cardapio/android/pages/android_home/home_menu_tile.dart';
import 'package:cardapio/android/pages/login/login_home.dart';
import 'package:cardapio/android/pages/order/menu_cart.dart';
import 'package:cardapio/android/pages/week_menu/days_of_week.dart';
import 'package:flutter/material.dart';

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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginHome(),
                ),
              );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DaysOfWeek(),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            HomeMenuTile(
              title: 'Reserva de Pratos',
              icon: Icons.reorder,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MenuCart(),
                  ),
                );
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
