import 'package:bloc/bloc.dart';
import 'package:cardapio/android/controllers/bloc/events/days_of_week_event.dart';
import 'package:cardapio/android/controllers/bloc/states/days_of_week_state.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/i_days_of_week_usecase.dart';
import 'package:cardapio/modules/week_menu/errors/errors.dart';

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
