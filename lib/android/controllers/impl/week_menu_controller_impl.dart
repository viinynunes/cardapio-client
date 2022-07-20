import 'package:cardapio/android/controllers/i_week_menu_controller.dart';

import '../../../modules/week_menu/domain/entities/item_menu.dart';

class WeekMenuControllerImpl implements IWeekMenuController {
  List<ItemMenu> menuList = [];

  @override
  Future<List<ItemMenu>> getItemMenuList() async {

    return [];
  }

  @override
  String getWeekDay(DateTime today) {
    if (today.weekday == 1) {
      return 'Segunda-Feira';
    }
    if (today.weekday == 2) {
      return 'Terça-Feira';
    }
    if (today.weekday == 3) {
      return 'Quarta-Feira';
    }
    if (today.weekday == 4) {
      return 'Quinta-Feira';
    }
    if (today.weekday == 5) {
      return 'Sexta-Feira';
    }
    if (today.weekday == 6) {
      return 'Sábado';
    }
    if (today.weekday == 7) {
      return 'Domingo';
    }

    return '';
  }
}
