import 'package:cardapio/android/controllers/bloc/events/menu_cart_events.dart';
import 'package:cardapio/android/controllers/bloc/menu_cart_bloc.dart';
import 'package:cardapio/android/controllers/bloc/states/menu_cart_states.dart';
import 'package:cardapio/android/pages/order/menu_cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MenuCart extends StatefulWidget {
  const MenuCart({Key? key}) : super(key: key);

  @override
  State<MenuCart> createState() => _MenuCartState();
}

class _MenuCartState extends State<MenuCart> {
  final bloc = Modular.get<MenuCartBloc>();

  @override
  void initState() {
    super.initState();

    bloc.add(GetMenuCartList());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Carrinho'),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: const [
                    Text(
                      'Confirmar pedido',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(Icons.save),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is MenuCartLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is MenuCartErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 100,
                    ),
                    Text(
                      state.error.message,
                      style: const TextStyle(fontSize: 50),
                    ),
                  ],
                ),
              );
            }

            if (state is MenuCartSuccessState) {
              final menuItemCartList = state.menuItemCartList;

              if (menuItemCartList.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 100,
                      ),
                      Text(
                        'Carrinho Vazio',
                        style: TextStyle(fontSize: 50),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: menuItemCartList.length,
                itemBuilder: (context, index) {
                  var item = menuItemCartList[index];

                  return MenuCartTile(
                    item: item,
                    removeItemButtonAction: () {
                      bloc.add(RemoveItemMenuFromCart(item));
                      bloc.add(GetMenuCartList());
                    },
                  );
                },
              );
            }

            return Container();
          },
        ));
  }
}
