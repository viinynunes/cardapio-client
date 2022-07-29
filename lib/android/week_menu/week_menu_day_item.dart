import 'package:cardapio/android/controllers/bloc/events/week_menu_day_item_events.dart';
import 'package:cardapio/android/controllers/bloc/week_menu_day_item_bloc.dart';
import 'package:cardapio/android/order/menu_cart.dart';
import 'package:flutter/material.dart';

import '../../modules/week_menu/domain/entities/item_menu.dart' as menu;

class WeekMenuDayItem extends StatefulWidget {
  const WeekMenuDayItem({Key? key, required this.menuItem}) : super(key: key);

  final menu.ItemMenu menuItem;

  @override
  State<WeekMenuDayItem> createState() => _WeekMenuDayItemState();
}

class _WeekMenuDayItemState extends State<WeekMenuDayItem> {
  late final WeekMenuDayItemBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = WeekMenuDayItemBloc();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.menuItem.name),
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
          bloc.add(AddItemMenuToCartEvent(widget.menuItem));
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
                    image: NetworkImage(widget.menuItem.imgUrl),
                    fit: BoxFit.cover),
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  widget.menuItem.name,
                  style: const TextStyle(fontSize: 25),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Card(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  widget.menuItem.description,
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
