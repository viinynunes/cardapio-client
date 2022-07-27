import 'package:cardapio/modules/week_menu/domain/entities/weekday.dart';
import 'package:cardapio/modules/week_menu/errors/get_menu_error.dart';
import 'package:dartz/dartz.dart';

abstract class IDaysOfWeekUsecase {
  Either<GetDaysOfWeekError, List<Weekday>> call(DateTime today);
}