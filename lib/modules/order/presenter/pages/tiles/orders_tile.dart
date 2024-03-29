import 'package:cardapio/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:cardapio/modules/order/domain/entities/order.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrdersTile extends StatelessWidget {
  const OrdersTile({Key? key, required this.order, required this.onTap})
      : super(key: key);

  final Order order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.1,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          child: Row(
            children: [
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(
                  dateFormat.format(order.registrationDate),
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                flex: 5,
                fit: FlexFit.tight,
                child: Text(
                  order.menuList.first.name,
                  textAlign: TextAlign.center,
                ),
              ),
              Flexible(
                flex: 2,
                fit: FlexFit.tight,
                child: Text(
                  order.status.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: order.status.name == OrderStatus.cancelled.name
                          ? Colors.red
                          : Colors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
