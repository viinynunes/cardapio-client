import 'package:cardapio/android/controllers/bloc/events/week_menu_day_item_events.dart';
import 'package:cardapio/android/controllers/bloc/menu_by_day_item_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../modules/week_menu/domain/entities/item_menu.dart' as menu;

class MenuByDayItem extends StatefulWidget {
  const MenuByDayItem({Key? key, required this.menuItem}) : super(key: key);

  final menu.ItemMenu menuItem;

  @override
  State<MenuByDayItem> createState() => _MenuByDayItemState();
}

class _MenuByDayItemState extends State<MenuByDayItem> {
  late final MenuByDayItemBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = MenuByDayItemBloc();
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
              Modular.to.pushNamed('/order');
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      floatingActionButton:
          widget.menuItem.weekdayList.contains(DateTime.now().weekday)
              ? FloatingActionButton(
                  onPressed: () {
                    bloc.add(AddItemMenuToCartEvent(widget.menuItem));
                  },
                  child: const Icon(Icons.add),
                )
              : null,
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
