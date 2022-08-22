import 'package:cardapio/modules/cart/presenter/bloc/cart_bloc.dart';
import 'package:cardapio/modules/cart/presenter/bloc/events/cart_events.dart';
import 'package:cardapio/modules/cart/presenter/bloc/states/cart_states.dart';
import 'package:cardapio/modules/cart/presenter/pages/tiles/cart_tile.dart';
import 'package:cardapio/modules/order/presenter/bloc/events/order_events.dart';
import 'package:cardapio/modules/order/presenter/bloc/states/order_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

import '../../../order/presenter/bloc/order_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with TickerProviderStateMixin {
  final cartBloc = Modular.get<CartBloc>();
  final orderBloc = Modular.get<OrderBloc>();
  late final AnimationController orderCompletedAnimationController;
  late final AnimationController orderLoadingAnimationController;

  @override
  void initState() {
    super.initState();

    cartBloc.add(GetCartListEvent());

    orderCompletedAnimationController = AnimationController(vsync: this);
    orderCompletedAnimationController.duration = const Duration(seconds: 2);

    orderLoadingAnimationController = AnimationController(vsync: this);
    orderLoadingAnimationController.duration = const Duration(seconds: 2);
  }

  @override
  void dispose() {
    orderLoadingAnimationController.dispose();
    orderCompletedAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<OrderBloc>(create: (context) => orderBloc),
        BlocProvider<CartBloc>(create: (context) => cartBloc),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Carrinho'),
          centerTitle: true,
          actions: [
            BlocBuilder<CartBloc, CartStates>(
              bloc: cartBloc,
              builder: (_, state) {
                if (state is CartGetCartListSuccessState) {
                  if (state.cartList.isNotEmpty) {
                    return GestureDetector(
                      onTap: () {
                        orderBloc.add(SendOrderEvent());
                      },
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
                    );
                  }
                }

                return Container(
                  color: Colors.purpleAccent,
                );
              },
            )
          ],
        ),
        body: SafeArea(
          child: Center(
            child: Stack(
              children: [
                BlocBuilder<CartBloc, CartStates>(
                  bloc: cartBloc,
                  builder: (context, state) {
                    if (state is CartLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is CartErrorState) {
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

                    if (state is CartGetCartListSuccessState) {
                      final menuItemCartList = state.cartList;

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

                          return CartTile(
                            item: item,
                            removeItemButtonAction: () {
                              cartBloc.add(RemoveItemFromCartEvent(item));
                              cartBloc.add(GetCartListEvent());
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

                    if (state is OrderSendOrderSuccessState) {
                      orderCompletedAnimationController.addStatusListener(
                        (status) {
                          status == AnimationStatus.completed
                              ? Modular.to.pushReplacementNamed('../order/')
                              : null;
                        },
                      );

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
