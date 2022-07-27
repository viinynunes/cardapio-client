import 'package:cardapio/android/controllers/bloc/days_of_week_bloc.dart';
import 'package:cardapio/android/controllers/bloc/states/days_of_week_state.dart';
import 'package:cardapio/android/week_menu/days_of_week_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controllers/bloc/events/days_of_week_event.dart';

class DaysOfWeek extends StatefulWidget {
  const DaysOfWeek({Key? key}) : super(key: key);

  @override
  State<DaysOfWeek> createState() => _DaysOfWeekState();
}

class _DaysOfWeekState extends State<DaysOfWeek> {
  late DaysOfWeekBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = DaysOfWeekBloc();
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
                return DaysOfWeekTile(weekday: weekday);
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
