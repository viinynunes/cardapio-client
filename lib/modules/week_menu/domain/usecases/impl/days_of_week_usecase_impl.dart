import 'package:cardapio/modules/week_menu/domain/entities/weekday.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/i_days_of_week_usecase.dart';
import 'package:cardapio/modules/week_menu/errors/get_menu_error.dart';
import 'package:dartz/dartz.dart';

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
      Weekday(1, 'Domingo', false),
      Weekday(2, 'Segunda-Feira', false),
      Weekday(3, 'Terça-Feira', false),
      Weekday(4, 'Quarta-Feira', false),
      Weekday(5, 'Quinta-Feira', false),
      Weekday(6, 'Sexta-Feira', false),
      Weekday(7, 'Sábado', false),
    ];
  }
}
