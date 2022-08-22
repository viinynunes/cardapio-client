import 'package:cardapio/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:cardapio/modules/order/presenter/bloc/events/order_events.dart';
import 'package:cardapio/modules/order/presenter/bloc/order_bloc.dart';
import 'package:cardapio/modules/order/presenter/bloc/states/order_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../domain/entities/order.dart';

class OrderItem extends StatefulWidget {
  const OrderItem({Key? key, required this.order}) : super(key: key);

  final Order order;

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem>
    with TickerProviderStateMixin {
  final bloc = Modular.get<OrderBloc>();

  late final AnimationController orderCancelConfirmedAniController;
  late final AnimationController orderCancelFailedAniController;

  @override
  void initState() {
    super.initState();

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
    final size = MediaQuery.of(context).size;
    final dateFormat = DateFormat('dd/MM/yyyy');
    bool eventPressed = false;

    Widget _getDecoratedContainer({double? height, required Widget child}) {
      return Container(
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 10),
          height: height != null ? size.height * height : null,
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(16)),
          child: child);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Pedido ${widget.order.id}'),
        centerTitle: true,
      ),
      body: WillPopScope(
        onWillPop: () async {
          Modular.to.pop(eventPressed);

          return eventPressed;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getDecoratedContainer(
                  height: 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: Text(
                          'Cliente',
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: Text(widget.order.user.name,
                            textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
                _getDecoratedContainer(
                  height: 0.07,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        fit: FlexFit.tight,
                        child: Text(
                          dateFormat.format(widget.order.registrationDate),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        fit: FlexFit.tight,
                        child: BlocBuilder<OrderBloc, OrderStates>(
                          bloc: bloc,
                          builder: (context, state) {
                            if (state is OrderSuccessState) {
                              widget.order.status = OrderStatus.cancelled;

                              return Text(
                                widget.order.status.name.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: widget.order.status.name ==
                                            OrderStatus.cancelled.name
                                        ? Colors.red
                                        : Colors.green),
                              );
                            }

                            return Text(
                              widget.order.status.name.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: widget.order.status.name ==
                                          OrderStatus.cancelled.name
                                      ? Colors.red
                                      : Colors.green),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                _getDecoratedContainer(
                  child: Column(
                    children: [
                      const Text('Pedido'),
                      ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: widget.order.menuList
                            .map(
                              (itemMenu) => ListTile(
                                leading: Container(
                                  width: 80,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                      image: NetworkImage(itemMenu.imgUrl),
                                      fit: BoxFit.cover,
                                      colorFilter: const ColorFilter.mode(
                                          Colors.black26, BlendMode.darken),
                                    ),
                                  ),
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      itemMenu.name,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      itemMenu.description,
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ],
                                ),
                                contentPadding: const EdgeInsets.all(8),
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<OrderBloc, OrderStates>(
                  bloc: bloc,
                  builder: (_, states) {
                    if (states is OrderSuccessState) {
                      return Container();
                    }

                    return widget.order.status == OrderStatus.open
                        ? _getDecoratedContainer(
                            height: 0.07,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    eventPressed = true;
                                    bloc.add(CancelOrderEvent(widget.order));
                                  },
                                  child: const Text('Cancelar Pedido'),
                                ),
                              ],
                            ),
                          )
                        : Container();
                  },
                ),
                BlocBuilder<OrderBloc, OrderStates>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is OrderLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (state is OrderSuccessState) {
                      orderCancelConfirmedAniController.forward();

                      return _getDecoratedContainer(
                        height: 0.2,
                        child: Center(
                          child: Lottie.asset(
                            'assets/lottie/order-cancel-confirmed.json',
                            controller: orderCancelConfirmedAniController,
                          ),
                        ),
                      );
                    }

                    if (state is OrderErrorState) {
                      orderCancelFailedAniController.forward();

                      return Scaffold(
                        backgroundColor: Colors.white,
                        body: Center(
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
                        ),
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
