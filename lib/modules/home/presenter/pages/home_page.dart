import 'package:cardapio/modules/home/presenter/pages/tiles/home_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha uma opção'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Modular.to.pushNamed('./order/cart');
              },
              icon: const Icon(Icons.shopping_cart_outlined))
        ],
        leading: IconButton(
          onPressed: () {
            Modular.to.navigate('/login/');
          },
          icon: const Icon(Icons.power_settings_new_outlined),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            HomeTile(
              title: 'Cardápio da Semana',
              icon: Icons.menu_book,
              onTap: () {
                Modular.to.pushNamed('/menu/');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            HomeTile(
              title: 'Meus Pedidos',
              icon: Icons.reorder,
              onTap: () {
                Modular.to.pushNamed('/order/');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            HomeTile(
              title: 'Pesquisa de Satisfação',
              icon: Icons.star_rate,
              onTap: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            HomeTile(
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
