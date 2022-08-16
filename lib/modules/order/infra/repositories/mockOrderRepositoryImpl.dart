import 'package:cardapio/modules/errors/errors.dart';
import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';
import 'package:cardapio/modules/order/domain/entities/enums/order_status_enum.dart';
import 'package:cardapio/modules/order/domain/repositories/i_order_repository.dart';
import 'package:dartz/dartz.dart';

import '../../../login/domain/entities/user.dart';
import '../../domain/entities/order.dart' as order;

class MockOrderRepositoryImpl implements IOrderRepository {
  @override
  Future<Either<OrderError, order.Order>> create(order.Order order) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right(order);
  }

  @override
  Future<Either<OrderError, order.Order>> cancel(order.Order order) async {
    await Future.delayed(const Duration(seconds: 2));

    order.status = OrderStatus.cancelled;

    //return Left(OrderError('Order Expired'));
    return Right(order);
  }

  @override
  Future<Either<OrderError, List<order.Order>>> getOrders(User user) async {
    await Future.delayed(const Duration(seconds: 2));

    return Right([
      order.Order(
          id: '125',
          user: user,
          menuList: [
            _getItemMenu(),
            _getItemMenu(),
          ],
          registrationDate: DateTime.now(),
          status: OrderStatus.open),
      order.Order(
          id: '126',
          user: user,
          menuList: [
            _getItemMenu(),
            _getItemMenu(),
            _getItemMenu(),
            _getItemMenu(),
          ],
          registrationDate: DateTime.now(),
          status: OrderStatus.confirmed),
      order.Order(
          id: '127',
          user: user,
          menuList: [
            _getItemMenu(),
            _getItemMenu(),
            _getItemMenu(),
            _getItemMenu(),
            _getItemMenu(),
            _getItemMenu(),
          ],
          registrationDate: DateTime.now(),
          status: OrderStatus.cancelled),
      order.Order(
          id: '128',
          user: user,
          menuList: [
            _getItemMenu(),
            _getItemMenu(),
            _getItemMenu(),
            _getItemMenu(),
            _getItemMenu(),
            _getItemMenu(),
          ],
          registrationDate: DateTime.now(),
          status: OrderStatus.closed),
      order.Order(
          id: '129',
          user: user,
          menuList: [
            _getItemMenu(),
            _getItemMenu(),
            _getItemMenu(),
            _getItemMenu(),
            _getItemMenu(),
          ],
          registrationDate: DateTime.now(),
          status: OrderStatus.closed),
    ]);
  }

  _getItemMenu() {
    return ItemMenu(
        name: 'Farofa Mineira com suco',
        description:
            'farofa feita com farinha, calabresa e bacon e suco de laranja natural',
        imgUrl: 'https://portal.fgv.br/sites/portal.fgv.br/files/'
            'styles/noticia_geral/public/noticias/set/17/'
            'prato-feito.jpg?itok=klqGuxxN&c=33313733cdad61e4bd51beabb4a84531',
        weekdayList: []);
  }
}
