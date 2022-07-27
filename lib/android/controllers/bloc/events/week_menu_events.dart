import 'package:cardapio/modules/week_menu/domain/entities/weekday.dart';

abstract class MenuEvent {}

class GetListByDayEvent extends MenuEvent {
  Weekday weekday;

  GetListByDayEvent(this.weekday);
}