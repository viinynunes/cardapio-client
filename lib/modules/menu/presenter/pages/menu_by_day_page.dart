import 'package:cardapio/modules/menu/domain/entities/weekday.dart';
import 'package:cardapio/modules/menu/presenter/bloc/events/menu_by_day_events.dart';
import 'package:cardapio/modules/menu/presenter/bloc/menu_by_day_bloc.dart';
import 'package:cardapio/modules/menu/presenter/bloc/states/menu_by_day_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MenuByDayPage extends StatefulWidget {
  const MenuByDayPage({Key? key, required this.weekday, required this.today})
      : super(key: key);

  final Weekday weekday;
  final Weekday today;

  @override
  State<MenuByDayPage> createState() => _MenuByDayPageState();
}

class _MenuByDayPageState extends State<MenuByDayPage> {
  final bloc = Modular.get<MenuByDayBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(MenuByDayListByDayEvent(widget.weekday));
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
                    ? Modular.to.pushNamed('./menu-by-day',
                        arguments: [widget.today, widget.today])
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
                  if (state is MenuByDayLoadingState) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is MenuByDayErrorState) {
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

                  if (state is MenuByDaySuccessState) {
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
                            Modular.to.pushNamed('././menu-by-day-item',
                                arguments: [item]);
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
