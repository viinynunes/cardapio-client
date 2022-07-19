abstract class IWeekMenuController {
  Future getItemMenuList();

  String getWeekDay(DateTime today);
}