import 'package:bloc/bloc.dart';
import 'package:cardapio/android/controllers/bloc/events/days_of_week_event.dart';
import 'package:cardapio/android/controllers/bloc/states/days_of_week_state.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/impl/days_of_week_usecase_impl.dart';
import 'package:cardapio/modules/week_menu/errors/get_menu_error.dart';

class DaysOfWeekBloc extends Bloc<DaysOfWeekEvent, DaysOfWeekState> {
  final usecase = DaysOfWeekUsecaseImpl();

  DaysOfWeekBloc() : super(DaysOfWeekInitialState()) {
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