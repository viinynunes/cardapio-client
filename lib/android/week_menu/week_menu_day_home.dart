import 'package:cardapio/android/controllers/week_menu_controller.dart';
import 'package:cardapio/android/week_menu/week_menu_day_item.dart';
import 'package:flutter/material.dart';

class WeekMenuDayHome extends StatefulWidget {
  const WeekMenuDayHome({Key? key}) : super(key: key);

  @override
  State<WeekMenuDayHome> createState() => _WeekMenuDayHomeState();
}

class _WeekMenuDayHomeState extends State<WeekMenuDayHome> {
  final controller = WeekMenuController();

  @override
  void initState() {
    super.initState();
    controller.getList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    String getWeekDay(){
      if(DateTime.now().weekday == 1){
        return 'Segunda-Feira';
      }
      if(DateTime.now().weekday == 2){
        return 'Terça-Feira';
      }
      if(DateTime.now().weekday == 3){
        return 'Quarta-Feira';
      }
      if(DateTime.now().weekday == 4){
        return 'Quinta-Feira';
      }
      if(DateTime.now().weekday == 5){
        return 'Sexta-Feira';
      }
      if(DateTime.now().weekday == 6){
        return 'Sábado';
      }
      if(DateTime.now().weekday == 7){
        return 'Domingo';
      }

      return '';
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pratos do dia'),
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('HOJE: '),
                Text(
                  getWeekDay(),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            )
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.9,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 1,
                  maxCrossAxisExtent: 300,
                ),
                itemCount: controller.menuList.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = controller.menuList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WeekMenuDayItem(menuItem: item),
                        ),
                      );
                    },
                    child: Stack(
                      children: [
                        Card(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(item.imgUrl),
                                fit: BoxFit.cover,
                                colorFilter: const ColorFilter.mode(
                                    Colors.black26, BlendMode.darken),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            item.name,
                            style: const TextStyle(
                                fontSize: 20, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
