import 'package:cardapio/modules/menu/presenter/bloc/events/menu_by_day_item_events.dart';
import 'package:cardapio/modules/menu/presenter/bloc/menu_by_day_item_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '/../../modules/menu/domain/entities/item_menu.dart' as menu;

class MenuByDayItemPage extends StatefulWidget {
  const MenuByDayItemPage({Key? key, required this.menuItem}) : super(key: key);

  final menu.ItemMenu menuItem;

  @override
  State<MenuByDayItemPage> createState() => _MenuByDayItemPageState();
}

class _MenuByDayItemPageState extends State<MenuByDayItemPage> {
  final bloc = Modular.get<MenuByDayItemBloc>();

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
              Modular.to.pushNamed('/order/');
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      floatingActionButton: widget.menuItem.weekdayList
              .contains(DateTime.now().weekday)
          ? FloatingActionButton(
              onPressed: () {
                bloc.add(MenuByDayItemAddItemMenuToCartEvent(widget.menuItem));
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
