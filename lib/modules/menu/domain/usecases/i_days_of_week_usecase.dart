import 'package:cardapio/modules/menu/domain/entities/weekday.dart';
import 'package:dartz/dartz.dart';

import '../../../errors/errors.dart';

abstract class IDaysOfWeekUsecase {
  Either<GetDaysOfWeekError, List<Weekday>> call(DateTime today);
}
