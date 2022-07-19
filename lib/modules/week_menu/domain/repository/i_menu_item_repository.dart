import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import '../../errors/get_menu_by_day_error.dart';

abstract class IMenuItemRepository {
  Either<GetMenuByDayError, List<MenuItem>> getMenuListByDay(DateTime dateTime);
}
