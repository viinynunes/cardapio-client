import 'package:bloc/bloc.dart';
import 'package:cardapio/android/controllers/bloc/events/events.dart';
import 'package:cardapio/android/controllers/bloc/states/states.dart';
import 'package:cardapio/modules/week_menu/domain/repository/mock_rep_impl.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/impl/menu_item_usecase_impl.dart';
import 'package:cardapio/modules/week_menu/errors/get_menu_error.dart';

class WeekMenuBlock extends Bloc<MenuEvent, MenuState> {
  final usecase = ItemMenuUsecaseImpl(MockRepImpl());

  WeekMenuBlock() : super(MenuInitialState()) {
    on<GetListByDayEvent>((event, emit) async {
      final result = await usecase.getItemMenuByDay(event.dateTime);

      if (result.isLeft()) {
        emit(MenuError(error: result.fold((l) => l, (r) => GetMenuError(''))));
      } else {
        emit(MenuSuccess(
            menuByDayList: result.fold((l) => [], (r) => r),
            error: GetMenuError('')));
      }
    });
  }
}
