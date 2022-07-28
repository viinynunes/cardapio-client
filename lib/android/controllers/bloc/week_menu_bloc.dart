import 'package:bloc/bloc.dart';
import 'package:cardapio/android/controllers/bloc/events/week_menu_events.dart';
import 'package:cardapio/android/controllers/bloc/states/week_menu_states.dart';
import 'package:cardapio/modules/week_menu/domain/repository/mock_rep_impl.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/impl/menu_item_usecase_impl.dart';

class WeekMenuBlock extends Bloc<MenuEvent, MenuState> {
  final usecase = ItemMenuUsecaseImpl(MockRepImpl());

  WeekMenuBlock() : super(MenuInitialState()) {
    on<GetListByDayEvent>((event, emit) async {
      emit(MenuLoadingState());

      final result = await usecase.getItemMenuByDay(event.weekday);

      result.fold((l) => emit(MenuErrorState(error: l)),
          (r) => emit(MenuSuccessState(menuByDayList: r)));
    });
  }
}
