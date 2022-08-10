import 'package:bloc/bloc.dart';
import 'package:cardapio/modules/menu/presenter/bloc/events/days_of_week_event.dart';
import 'package:cardapio/modules/menu/presenter/bloc/states/days_of_week_state.dart';
import 'package:cardapio/modules/menu/domain/usecases/i_days_of_week_usecase.dart';

import '../../../errors/errors.dart';

class DaysOfWeekBloc extends Bloc<DaysOfWeekEvent, DaysOfWeekState> {
  final IDaysOfWeekUsecase usecase;

  DaysOfWeekBloc(this.usecase) : super(DaysOfWeekInitialState()) {
    on<GetOrderedWeekdaysOrderedByToday>((event, emit) async {
      emit(DaysOfWeekLoading());

      final result = usecase(DateTime.now());

      if (result.isLeft()) {
        emit(DaysOfWeekError(
            result.fold((l) => l, (r) => GetDaysOfWeekError(''))));
      } else {
        emit(DaysOfWeekSuccess(
            result.fold((l) => [], (r) => r), GetDaysOfWeekError('')));
      }
    });
  }
}
