import 'package:cardapio/modules/menu/domain/entities/weekday.dart';
import 'package:cardapio/modules/menu/domain/usecases/i_days_of_week_usecase.dart';
import 'package:dartz/dartz.dart';

import '../../../../errors/errors.dart';

class DaysOfWeekUsecaseImpl implements IDaysOfWeekUsecase {
  @override
  Either<GetDaysOfWeekError, List<Weekday>> call(DateTime today) {
    if (today.weekday <= 0 || today.weekday > 7) {
      return Left(GetDaysOfWeekError('Invalid weekday'));
    }

    List<Weekday> list = _getWeekdayList();

    final todayAux =
        list.singleWhere((element) => today.weekday == element.weekday);

    todayAux.today = true;

    list.sort((a, b) => todayAux.weekday.compareTo(a.weekday));

    return Right(list);
  }

  _getWeekdayList() {
    return [
      Weekday(1, 'Segunda-Feira', false),
      Weekday(2, 'Terça-Feira', false),
      Weekday(3, 'Quarta-Feira', false),
      Weekday(4, 'Quinta-Feira', false),
      Weekday(5, 'Sexta-Feira', false),
      Weekday(6, 'Sábado', false),
      Weekday(7, 'Domingo', false),
    ];
  }
}
