import 'package:cardapio/modules/order/presenter/bloc/events/order_events.dart';
import 'package:cardapio/modules/order/presenter/bloc/order_bloc.dart';
import 'package:cardapio/modules/order/presenter/bloc/states/order_states.dart';
import 'package:cardapio/modules/order/presenter/pages/tiles/personal_orders_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class PersonalOrders extends StatefulWidget {
  const PersonalOrders({Key? key}) : super(key: key);

  @override
  State<PersonalOrders> createState() => _PersonalOrdersState();
}

class _PersonalOrdersState extends State<PersonalOrders>
    with TickerProviderStateMixin {
  final bloc = Modular.get<OrderBloc>();

  @override
  void initState() {
    super.initState();

    bloc.add(GetOrdersEvent());
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
              Modular.to.pushNamed('../cart/');
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
                    onTap: () async {
                      final eventPressed = await Modular.to
                          .pushNamed('./order-item/', arguments: [order]);
                      eventPressed == true ? bloc.add(GetOrdersEvent()) : null;
                      //bloc.add(GetOrdersEvent());
                    },
                  );
                },
              ),
            );
          }

          if (state is OrderErrorState) {
            return Center(
              child: Text(
                state.orderError.message,
                style: const TextStyle(fontSize: 25),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
