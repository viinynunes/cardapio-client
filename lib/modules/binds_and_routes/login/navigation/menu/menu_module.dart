import 'package:cardapio/modules/menu/domain/usecases/impl/days_of_week_usecase_impl.dart';
import 'package:cardapio/modules/menu/domain/usecases/impl/menu_item_usecase_impl.dart';
import 'package:cardapio/modules/menu/external/datasources/impl/item_menu_firebase_datasource.dart';
import 'package:cardapio/modules/menu/infra/repositories/item_menu_repository_impl.dart';
import 'package:cardapio/modules/menu/presenter/bloc/days_of_week_bloc.dart';
import 'package:cardapio/modules/menu/presenter/bloc/menu_by_day_bloc.dart';
import 'package:cardapio/modules/menu/presenter/pages/days_of_week_page.dart';
import 'package:cardapio/modules/menu/presenter/pages/menu_by_day_item_page.dart';
import 'package:cardapio/modules/menu/presenter/pages/menu_by_day_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MenuModule extends Module {
  @override
  List<Bind> get binds => [
        //Days of week dependencies
        Bind((i) => DaysOfWeekUsecaseImpl()),
        Bind((i) => DaysOfWeekBloc(i())),

        //ItemMenu dependencies
        Bind((i) => ItemMenuFirebaseDatasource()),
        Bind((i) => ItemMenuRepositoryImpl(i())),
        Bind((i) => ItemMenuUsecaseImpl(i())),
        Bind((i) => MenuByDayBloc(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const DaysOfWeekPage()),
        ChildRoute('/menu-by-day',
            child: (_, args) =>
                MenuByDayPage(weekday: args.data[0], today: args.data[1])),
        ChildRoute('/menu-by-day-item',
            child: (_, args) => MenuByDayItemPage(menuItem: args.data[0])),
      ];
}
