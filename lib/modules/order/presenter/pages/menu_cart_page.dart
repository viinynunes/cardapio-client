import 'package:cardapio/modules/order/presenter/bloc/events/menu_cart_events.dart';
import 'package:cardapio/modules/order/presenter/bloc/events/order_events.dart';
import 'package:cardapio/modules/order/presenter/bloc/menu_cart_bloc.dart';
import 'package:cardapio/modules/order/presenter/bloc/states/menu_cart_states.dart';
import 'package:cardapio/modules/order/presenter/bloc/states/order_states.dart';
import 'package:cardapio/modules/order/presenter/pages/tiles/menu_cart_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

import '../bloc/order_bloc.dart';

class MenuCartPage extends StatefulWidget {
  const MenuCartPage({Key? key}) : super(key: key);

  @override
  State<MenuCartPage> createState() => _MenuCartPageState();
}

class _MenuCartPageState extends State<MenuCartPage>
    with TickerProviderStateMixin {
  final menuCartBloc = Modular.get<MenuCartBloc>();
  final orderBloc = Modular.get<OrderBloc>();
  late final AnimationController orderCompletedAnimationController;
  late final AnimationController orderLoadingAnimationController;

  @override
  void initState() {
    super.initState();

    menuCartBloc.add(GetMenuCartList());

    orderCompletedAnimationController = AnimationController(vsync: this);
    orderCompletedAnimationController.duration = const Duration(seconds: 2);

    orderLoadingAnimationController = AnimationController(vsync: this);
    orderLoadingAnimationController.duration = const Duration(seconds: 2);
  }

  @override
  void dispose() {
    menuCartBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderBloc>(create: (context) => orderBloc),
        BlocProvider<MenuCartBloc>(create: (context) => menuCartBloc),
      ],
      child: Scaffold(
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
                    orderBloc.add(SendOrderEvent());
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
        body: SafeArea(
          child: Center(
            child: Stack(
              children: [
                BlocBuilder<MenuCartBloc, MenuCartStates>(
                  bloc: menuCartBloc,
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

                    if (state is MenuCartSuccessState) {
                      final menuItemCartList = state.menuItemCartList;

                      if (menuItemCartList.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: menuItemCartList.length,
                        itemBuilder: (context, index) {
                          var item = menuItemCartList[index];

                          return MenuCartTile(
                            item: item,
                            removeItemButtonAction: () {
                              menuCartBloc.add(RemoveItemMenuFromCart(item));
                              menuCartBloc.add(GetMenuCartList());
                            },
                          );
                        },
                      );
                    }

                    return Container();
                  },
                ),
                BlocBuilder<OrderBloc, OrderStates>(
                  bloc: orderBloc,
                  builder: (context, state) {
                    if (state is OrderLoadingState) {
                      orderLoadingAnimationController.forward();
                      return Scaffold(
                        backgroundColor: Colors.white,
                        body: Center(
                            child: Lottie.asset(
                                'assets/lottie/loading-order.json')),
                      );
                    }

                    if (state is OrderSuccessState) {
                      menuCartBloc.add(GetMenuCartList());
                      orderCompletedAnimationController.forward();

                      return Scaffold(
                        backgroundColor: Colors.white,
                        body: Center(
                            child: Lottie.asset(
                                'assets/lottie/order-complete.json',
                                controller: orderCompletedAnimationController)),
                      );
                    }

                    return Container();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
