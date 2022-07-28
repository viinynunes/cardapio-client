import 'package:cardapio/android/controllers/bloc/events/week_menu_events.dart';
import 'package:cardapio/android/controllers/bloc/states/week_menu_states.dart';
import 'package:cardapio/android/controllers/bloc/week_menu_bloc.dart';
import 'package:cardapio/android/week_menu/week_menu_day_item.dart';
import 'package:cardapio/modules/week_menu/domain/entities/weekday.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeekMenuDayHome extends StatefulWidget {
  const WeekMenuDayHome({Key? key, required this.weekday, required this.today})
      : super(key: key);

  final Weekday weekday;
  final Weekday today;

  @override
  State<WeekMenuDayHome> createState() => _WeekMenuDayHomeState();
}

class _WeekMenuDayHomeState extends State<WeekMenuDayHome> {
  late final WeekMenuBlock bloc;

  @override
  void initState() {
    super.initState();

    bloc = WeekMenuBlock();
    bloc.add(GetListByDayEvent(widget.weekday));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Pratos de ${widget.weekday.name}'),
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () {
                !widget.weekday.today
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WeekMenuDayHome(
                                weekday: widget.today, today: widget.today)))
                    : null;
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('HOJE: '),
                  Text(
                    widget.today.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.9,
              child: BlocBuilder(
                bloc: bloc,
                builder: (context, state) {
                  if (state is MenuLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is MenuErrorState) {
                    final error = state.error;

                    return Center(
                      child: Container(
                        height: 200,
                        width: 200,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.red,
                        ),
                        child: Text(
                          error.message,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 30),
                        ),
                      ),
                    );
                  }

                  if (state is MenuSuccessState) {
                    final menuItemList = state.menuByDayList;

                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
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
                                builder: (context) =>
                                    WeekMenuDayItem(menuItem: item),
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
                    );
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
