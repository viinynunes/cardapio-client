import 'package:cardapio/modules/week_menu/errors/get_menu_by_day_error.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

abstract class IGetMenuByDayUsecase {
  Either<GetMenuByDayError, List<MenuItem>> getMenuListByDay(DateTime dateTime);
}
