import 'package:dartz/dartz.dart';

import '../../errors/get_menu_by_day_error.dart';
import '../entities/menu_item.dart';

abstract class IMenuItemRepository {
  Either<GetMenuByDayError, List<MenuItem>> getMenuListByDay(DateTime dateTime);
}
