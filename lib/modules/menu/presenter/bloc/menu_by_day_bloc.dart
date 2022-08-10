import 'package:bloc/bloc.dart';
import 'package:cardapio/modules/menu/presenter/bloc/events/menu_by_day_events.dart';
import 'package:cardapio/modules/menu/presenter/bloc/states/menu_by_day_states.dart';
import 'package:cardapio/modules/menu/domain/usecases/i_menu_item_usecase.dart';

class MenuByDayBloc extends Bloc<MenuByDayEvents, MenuByDayStates> {
  final IItemMenuUsecase usecase;

  MenuByDayBloc(this.usecase) : super(MenuByDayInitialState()) {
    on<MenuByDayListByDayEvent>((event, emit) async {
      emit(MenuByDayLoadingState());

      final result = await usecase.getItemMenuByDay(event.weekday);

      result.fold((l) => emit(MenuByDayErrorState(error: l)),
          (r) => emit(MenuByDaySuccessState(menuByDayList: r)));
    });
  }
}
