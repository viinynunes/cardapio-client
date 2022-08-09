import 'package:cardapio/android/pages/week_menu/days_of_week.dart';
import 'package:cardapio/android/pages/week_menu/week_menu_day_home.dart';
import 'package:cardapio/android/pages/week_menu/week_menu_day_item.dart';
import 'package:flutter_modular/flutter_modular.dart';

class WeekMenuModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const DaysOfWeek()),
        ChildRoute('/menu-by-day',
            child: (_, args) =>
                WeekMenuDayHome(weekday: args.data[0], today: args.data[1])),
        ChildRoute('/menu-by-day-item',
            child: (_, args) => WeekMenuDayItem(menuItem: args.data[0])),
      ];
}
