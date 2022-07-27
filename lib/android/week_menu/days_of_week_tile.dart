import 'package:cardapio/android/week_menu/week_menu_day_home.dart';
import 'package:cardapio/modules/week_menu/domain/entities/weekday.dart';
import 'package:flutter/material.dart';

class DaysOfWeekTile extends StatelessWidget {
  const DaysOfWeekTile({Key? key, required this.weekday}) : super(key: key);

  final Weekday weekday;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => WeekMenuDayHome(weekday: weekday,),
          ),
        );
      },
      child: Card(
        child: Container(
          height: size.height * 0.1,
          color: Colors.grey.withOpacity(0.3),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              const Flexible(
                fit: FlexFit.tight,
                child: Icon(
                  Icons.calendar_month,
                  size: 30,
                  color: Colors.red,
                ),
              ),
              Flexible(
                flex: 3,
                fit: FlexFit.tight,
                child: Text(
                  weekday.name,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Icon(
                  Icons.star_border_purple500_outlined,
                  color: Colors.red,
                  size: weekday.today ? 30 : 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
