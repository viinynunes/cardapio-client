import 'package:cardapio/modules/week_menu/domain/entities/weekday.dart';
import 'package:cardapio/modules/week_menu/errors/errors.dart';

abstract class DaysOfWeekState {
  List<Weekday> weekdaysList;
  GetDaysOfWeekError error;

  DaysOfWeekState({required this.weekdaysList, required this.error});
}

class DaysOfWeekInitialState extends DaysOfWeekState {
  DaysOfWeekInitialState()
      : super(weekdaysList: [], error: GetDaysOfWeekError(''));
}

class DaysOfWeekLoading extends DaysOfWeekState {
  DaysOfWeekLoading()
      : super(weekdaysList: [], error: GetDaysOfWeekError(''));
}

class DaysOfWeekSuccess extends DaysOfWeekState {
  DaysOfWeekSuccess(List<Weekday> weekdaysList, GetDaysOfWeekError error)
      : super(weekdaysList: weekdaysList, error: GetDaysOfWeekError(''));
}

class DaysOfWeekError extends DaysOfWeekState {
  DaysOfWeekError(GetDaysOfWeekError error)
      : super(weekdaysList: [], error: error);
}
