abstract class MenuEvent {}

class GetListByDayEvent extends MenuEvent {
  DateTime dateTime;

  GetListByDayEvent(this.dateTime);
}