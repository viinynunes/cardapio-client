import 'package:cardapio/android/controllers/impl/week_menu_controller_impl.dart';
import 'package:cardapio/android/week_menu/week_menu_day_home.dart';
import 'package:flutter/material.dart';

class DaysOfWeek extends StatelessWidget {
  const DaysOfWeek({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    getTile(String weekDay) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  WeekMenuDayHome(controller: WeekMenuControllerImpl()),
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
                    weekDay,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione o dia'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          getTile('Domingo'),
          const SizedBox(
            height: 5,
          ),
          getTile('Segunda-Feira'),
          const SizedBox(
            height: 5,
          ),
          getTile('Terça-Feira'),
          const SizedBox(
            height: 5,
          ),
          getTile('Quarta-Feira'),
          const SizedBox(
            height: 5,
          ),
          getTile('Quinta-Feira'),
          const SizedBox(
            height: 5,
          ),
          getTile('Sexta-Feira'),
          const SizedBox(
            height: 5,
          ),
          getTile('Sábado'),
        ],
      ),
    );
  }
}
