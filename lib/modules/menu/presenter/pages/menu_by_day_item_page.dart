import 'package:cardapio/modules/cart/presenter/bloc/cart_bloc.dart';
import 'package:cardapio/modules/cart/presenter/bloc/events/cart_events.dart';
import 'package:cardapio/modules/cart/presenter/bloc/states/cart_states.dart';
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
  final bloc = Modular.get<CartBloc>();

  late final AnimationController _cartIconController;

  @override
  void initState() {
    super.initState();
    _cartIconController = AnimationController(vsync: this);
    _cartIconController.duration = const Duration(seconds: 1);

    bloc.add(GetCartListEvent());
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
          BlocListener<CartBloc, CartStates>(
            bloc: bloc,
            listener: (context, state) {
              if (state is CartErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error.message),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            child: BlocBuilder<CartBloc, CartStates>(
              bloc: bloc,
              builder: (context, state) {
                if (state is CartGetCartListSuccessState) {
                  return Center(
                    child: Text(state.cartList.length.toString()),
                  );
                }

                if (state is CartLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white,)
                  );
                }

                return Container();
              },
            ),
          ),
          GestureDetector(
              onTap: () async {
                await Modular.to.pushNamed('../cart/');

                bloc.add(GetCartListEvent());
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
      floatingActionButton:
          widget.menuItem.weekdayList.contains(DateTime.now().weekday)
              ? FloatingActionButton(
                  onPressed: () async {
                    _cartIconController.forward();
                    bloc.add(AddItemToCartEvent(widget.menuItem));
                    bloc.add(GetCartListEvent());

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
      )),
    );
  }
}
