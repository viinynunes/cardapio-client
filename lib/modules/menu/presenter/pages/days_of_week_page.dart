import 'package:cardapio/modules/menu/presenter/bloc/days_of_week_bloc.dart';
import 'package:cardapio/modules/menu/presenter/bloc/events/days_of_week_event.dart';
import 'package:cardapio/modules/menu/presenter/bloc/states/days_of_week_state.dart';
import 'package:cardapio/modules/menu/presenter/pages/tiles/days_of_week_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DaysOfWeekPage extends StatefulWidget {
  const DaysOfWeekPage({Key? key}) : super(key: key);

  @override
  State<DaysOfWeekPage> createState() => _DaysOfWeekPageState();
}

class _DaysOfWeekPageState extends State<DaysOfWeekPage> {
  final bloc = Modular.get<DaysOfWeekBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(GetOrderedWeekdaysOrderedByToday(DateTime.now()));
  }

  @override
  void dispose() {
    bloc.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecione o dia'),
        centerTitle: true,
      ),
      body: BlocBuilder(
        bloc: bloc,
        builder: (context, state) {
          if (state is DaysOfWeekLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is DaysOfWeekError) {
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
                  style: const TextStyle(color: Colors.white, fontSize: 30),
                ),
              ),
            );
          }
          if (state is DaysOfWeekSuccess) {
            final list = state.weekdaysList;
            return ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, index) {
                final weekday = list[index];
                return DaysOfWeekTile(
                  weekday: weekday,
                  onClickPage: () {
                    Modular.to.pushNamed('././menu-by-day', arguments: [
                      weekday,
                      list.singleWhere((element) => element.today == true),
                    ]);
                  },
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
