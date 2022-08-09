import 'package:cardapio/android/controllers/bloc/days_of_week_bloc.dart';
import 'package:cardapio/android/controllers/bloc/menu_by_day_bloc.dart';
import 'package:cardapio/android/controllers/bloc/menu_by_day_item_bloc.dart';
import 'package:cardapio/android/pages/week_menu/days_of_week.dart';
import 'package:cardapio/android/pages/week_menu/menu_by_day.dart';
import 'package:cardapio/android/pages/week_menu/menu_by_day_item.dart';
import 'package:cardapio/modules/week_menu/domain/repository/mock_rep_impl.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/impl/days_of_week_usecase_impl.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/impl/menu_cart_usecase_impl.dart';
import 'package:cardapio/modules/week_menu/domain/usecases/impl/menu_item_usecase_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WeekMenuModule extends Module {
  @override
  List<Bind> get binds => [
    Bind.factory((i) => DaysOfWeekUsecaseImpl()),
    Bind.singleton((i) => DaysOfWeekBloc(i())),

    Bind.factory((i) => MockRepImpl()),
    Bind.factory((i) => ItemMenuUsecaseImpl(i())),
    Bind.singleton((i) => MenuByDayBloc(i())),

    Bind.factory((i) => MockRepMenuCartImpl()),
    Bind.factory((i) => MenuCartUsecaseImpl(i())),
    Bind.singleton((i) => MenuByDayItemBloc(i())),
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const DaysOfWeek()),
        ChildRoute('/menu-by-day',
            child: (_, args) =>
                MenuByDayHome(weekday: args.data[0], today: args.data[1])),
        ChildRoute('/menu-by-day-item',
            child: (_, args) => MenuByDayItem(menuItem: args.data[0])),
      ];
}
