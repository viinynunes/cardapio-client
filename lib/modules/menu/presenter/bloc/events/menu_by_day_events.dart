import 'package:cardapio/modules/menu/domain/entities/weekday.dart';

abstract class MenuByDayEvents {}

class MenuByDayListByDayEvent extends MenuByDayEvents {
  Weekday weekday;

  MenuByDayListByDayEvent(this.weekday);
}