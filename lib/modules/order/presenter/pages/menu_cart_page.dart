import 'package:cardapio/modules/order/presenter/bloc/events/menu_cart_events.dart';
import 'package:cardapio/modules/order/presenter/bloc/menu_cart_bloc.dart';
import 'package:cardapio/modules/order/presenter/bloc/states/menu_cart_states.dart';
import 'package:cardapio/modules/order/presenter/pages/tiles/menu_cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

class MenuCartPage extends StatefulWidget {
  const MenuCartPage({Key? key}) : super(key: key);

  @override
  State<MenuCartPage> createState() => _MenuCartPageState();
}

class _MenuCartPageState extends State<MenuCartPage>
    with TickerProviderStateMixin {
  final bloc = Modular.get<MenuCartBloc>();
  late final AnimationController orderCompletedAnimationController;

  @override
  void initState() {
    super.initState();

    bloc.add(GetMenuCartList());

    orderCompletedAnimationController = AnimationController(vsync: this);
    orderCompletedAnimationController.duration = const Duration(seconds: 2);
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
                child: GestureDetector(
                  onTap: () {
                    bloc.add(MenuCartSendOrder());
                  },
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
            ),
          ],
        ),
        body: BlocBuilder<MenuCartBloc, MenuCartStates>(
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
                      state.menuCartError?.message ?? '',
                      style: const TextStyle(fontSize: 50),
                    ),
                  ],
                ),
              );
            }

            if (state is MenuCartGetMenuListSuccessState) {
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

            if (state is MenuCartSendOrderSuccessState) {
              orderCompletedAnimationController.forward();

              return Center(
                  child: Lottie.asset('assets/lottie/order-complete.json',
                      controller: orderCompletedAnimationController));
            }

            return Container();
          },
        ));
  }
}
