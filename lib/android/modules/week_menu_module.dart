import 'package:cardapio/android/pages/week_menu/days_of_week.dart';
import 'package:cardapio/android/pages/week_menu/menu_by_day.dart';
import 'package:cardapio/android/pages/week_menu/menu_by_day_item.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WeekMenuModule extends Module {
  @override
  List<Bind> get binds => [];

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
