import 'package:cardapio/modules/order/presenter/bloc/events/order_events.dart';
import 'package:cardapio/modules/order/presenter/bloc/order_bloc.dart';
import 'package:cardapio/modules/order/presenter/bloc/states/order_states.dart';
import 'package:cardapio/modules/order/presenter/pages/tiles/personal_orders_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';

class PersonalOrders extends StatefulWidget {
  const PersonalOrders({Key? key}) : super(key: key);

  @override
  State<PersonalOrders> createState() => _PersonalOrdersState();
}

class _PersonalOrdersState extends State<PersonalOrders>
    with TickerProviderStateMixin {
  final bloc = Modular.get<OrderBloc>();

  late final AnimationController orderCancelConfirmedAniController;
  late final AnimationController orderCancelFailedAniController;

  @override
  void initState() {
    super.initState();

    bloc.add(GetOrdersEvent());

    orderCancelConfirmedAniController = AnimationController(vsync: this);
    orderCancelConfirmedAniController.duration = const Duration(seconds: 2);

    orderCancelFailedAniController = AnimationController(vsync: this);
    orderCancelFailedAniController.duration = const Duration(seconds: 2);
  }

  @override
  void dispose() {
    orderCancelFailedAniController.dispose();
    orderCancelConfirmedAniController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Pedidos'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pushNamed('/cart/');
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
      ),
      body: BlocBuilder<OrderBloc, OrderStates>(
        bloc: bloc,
        builder: (context, state) {
          if (state is OrderLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is OrderGetListSuccessState) {
            final orderList = state.orderList;

            return SafeArea(
              child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: (context, index) {
                  var order = orderList[index];

                  return PersonalOrdersTile(
                    order: order,
                    onTap: () {},
                  );
                },
              ),
            );
          }

          if (state is OrderSuccessState) {
            orderCancelConfirmedAniController.forward();

            return Center(
              child: Lottie.asset(
                'assets/lottie/order-cancel-confirmed.json',
                controller: orderCancelConfirmedAniController,
              ),
            );
          }

          if (state is OrderErrorState) {
            orderCancelFailedAniController.forward();

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    'assets/lottie/order-cancel-failed.json',
                    controller: orderCancelFailedAniController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    state.orderError.message,
                    style: const TextStyle(fontSize: 25),
                  ),
                ],
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
