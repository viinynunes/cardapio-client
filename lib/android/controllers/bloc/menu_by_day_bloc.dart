import 'package:bloc/bloc.dart';
import 'package:cardapio/android/controllers/bloc/events/week_menu_events.dart';
import 'package:cardapio/android/controllers/bloc/states/week_menu_states.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/i_menu_item_usecase.dart';

class MenuByDayBloc extends Bloc<MenuEvent, MenuState> {
  final IItemMenuUsecase usecase;

  MenuByDayBloc(this.usecase) : super(MenuInitialState()) {
    on<GetListByDayEvent>((event, emit) async {
      emit(MenuLoadingState());

      final result = await usecase.getItemMenuByDay(event.weekday);

      result.fold((l) => emit(MenuErrorState(error: l)),
          (r) => emit(MenuSuccessState(menuByDayList: r)));
    });
  }
}
