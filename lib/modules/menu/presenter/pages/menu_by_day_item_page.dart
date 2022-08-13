import 'package:cardapio/modules/menu/presenter/bloc/events/menu_by_day_item_events.dart';
import 'package:cardapio/modules/menu/presenter/bloc/menu_by_day_item_bloc.dart';
import 'package:cardapio/modules/menu/presenter/bloc/states/menu_by_day_item_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

import '/../../modules/menu/domain/entities/item_menu.dart' as menu;

class MenuByDayItemPage extends StatefulWidget {
  const MenuByDayItemPage({Key? key, required this.menuItem}) : super(key: key);

  final menu.ItemMenu menuItem;

  @override
  State<MenuByDayItemPage> createState() => _MenuByDayItemPageState();
}

class _MenuByDayItemPageState extends State<MenuByDayItemPage>
    with TickerProviderStateMixin {
  final bloc = Modular.get<MenuByDayItemBloc>();

  late final AnimationController _cartIconController;

  @override
  void initState() {
    super.initState();
    _cartIconController = AnimationController(vsync: this);
    _cartIconController.duration = const Duration(seconds: 1);

    bloc.add(MenuByDayItemGetMenuCartEvent());
  }

  @override
  void dispose() {
    _cartIconController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.menuItem.name),
        centerTitle: true,
        actions: [
          BlocBuilder<MenuByDayItemBloc, MenuByDayItemStates>(
            bloc: bloc,
            builder: (context, state) {
              if (state is MenuByDayItemSuccessState) {
                return Center(
                  child: Text(state.itemMenuList!.length.toString()),
                );
              }

              return Container();
            },
          ),
          GestureDetector(
              onTap: () async {
                await Modular.to.pushNamed('/cart/');

                bloc.add(MenuByDayItemGetMenuCartEvent());
              },
              child: Stack(
                children: [
                  Center(
                    child: Lottie.asset('assets/lottie/cart-checkout.json',
                        controller: _cartIconController),
                  ),
                ],
              ))
        ],
      ),
      floatingActionButton: widget.menuItem.weekdayList
              .contains(DateTime.now().weekday)
          ? FloatingActionButton(
              onPressed: () async {
                bloc.add(MenuByDayItemAddItemMenuToCartEvent(widget.menuItem));
                bloc.add(MenuByDayItemGetMenuCartEvent());

                _cartIconController.forward();
                await Future.delayed(const Duration(seconds: 1));

                _cartIconController.reset();
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
