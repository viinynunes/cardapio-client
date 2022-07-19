import 'package:cardapio/android/controllers/i_week_menu_controller.dart';
import 'package:cardapio/android/week_menu/week_menu_day_item.dart';
import 'package:cardapio/modules/week_menu/domain/entities/item_menu.dart';
import 'package:flutter/material.dart';

class WeekMenuDayHome extends StatefulWidget {
  const WeekMenuDayHome({Key? key, required this.controller}) : super(key: key);

  final IWeekMenuController controller;

  @override
  State<WeekMenuDayHome> createState() => _WeekMenuDayHomeState();
}

class _WeekMenuDayHomeState extends State<WeekMenuDayHome> {
  late List<ItemMenu> menuItemList;

  @override
  void initState() async {
    super.initState();
    menuItemList = await widget.controller.getItemMenuList();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                    widget.controller.getWeekDay(DateTime.now()),
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              )),
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
                itemCount: menuItemList.length,
                itemBuilder: (BuildContext context, int index) {
                  var item = menuItemList[index];
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
