import 'package:cardapio/android/order/menu_cart.dart';
import 'package:flutter/material.dart';

import '../../modules/week_menu/domain/entities/menu_item.dart' as menu;
import '../controllers/week_menu_day_controller.dart';

class WeekMenuDayItem extends StatelessWidget {
  const WeekMenuDayItem({Key? key, required this.menuItem}) : super(key: key);

  final menu.MenuItem menuItem;

  @override
  Widget build(BuildContext context) {
    final controller = WeekMenuDayController(menuItem);

    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(menuItem.name),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MenuCart(),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.addItemToOrder();
        },
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: size.height * 0.4,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(menuItem.imgUrl), fit: BoxFit.cover),
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  menuItem.name,
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  menuItem.description,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
