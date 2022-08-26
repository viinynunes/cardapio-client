import 'package:cardapio/modules/home/presenter/pages/tiles/home_tile.dart';
import 'package:cardapio/modules/login/presenter/bloc/events/logged_user_events.dart';
import 'package:cardapio/modules/login/presenter/bloc/states/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../login/presenter/bloc/events/login_events.dart';
import '../../../login/presenter/bloc/logged_user_bloc.dart';
import '../../../login/presenter/bloc/login_bloc.dart';
import '../../../login/presenter/bloc/states/logged_user_states.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final loginBloc = Modular.get<LoginBloc>();
  final loggedUserBloc = Modular.get<LoggedUserBloc>();

  @override
  void initState() {
    super.initState();

    loggedUserBloc.add(GetLoggedUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => loginBloc),
        BlocProvider<LoggedUserBloc>(create: (context) => loggedUserBloc)
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Escolha uma opção'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Modular.to.pushNamed('../cart/');
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ],
          leading: IconButton(
            onPressed: () {
              loginBloc.add(UserLogoutEvent());
              Modular.to.pushReplacementNamed('/login/');
            },
            icon: const Icon(Icons.power_settings_new_outlined),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Stack(
            children: [
              ListView(
                children: [
                  HomeTile(
                    title: 'Cardápio da Semana',
                    icon: Icons.menu_book,
                    onTap: () {
                      Modular.to.pushNamed('../menu/');
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  HomeTile(
                    title: 'Meus Pedidos',
                    icon: Icons.reorder,
                    onTap: () {
                      Modular.to.pushNamed('../order/');
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  HomeTile(
                    title: 'Pesquisa de Satisfação',
                    icon: Icons.star_rate,
                    onTap: () {
                      Modular.to.pushNamed('../survey/');
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  HomeTile(
                    title: 'Site',
                    icon: Icons.link,
                    onTap: () {},
                  ),
                ],
              ),
              BlocListener(
                bloc: loginBloc,
                listener: (_, state) {
                  if (state is LoginErrorState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Erro ao realizar o logout'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }

                  if (state is LoginLogoutSuccessState) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Logout realizado com sucesso'),
                        backgroundColor: Colors.blue,
                      ),
                    );
                  }
                },
                child: BlocBuilder<LoginBloc, LoginStates>(
                  bloc: loginBloc,
                  builder: (_, state) {
                    if (state is LoginLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return Container();
                  },
                ),
              ),
            ],
          ),
        ),
        bottomSheet: BlocBuilder<LoggedUserBloc, LoggedUserStates>(
          bloc: loggedUserBloc,
          builder: (_, state) {
            if (state is LoggedUserLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is LoggedUserErrorState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(8),
                    height: size.height * 0.04,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ],
              );
            }

            if (state is LoggedUserSuccessState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.all(4),
                    padding: const EdgeInsets.all(8),
                    height: size.height * 0.04,
                    width: size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Center(
                      child: Text(
                        state.user.name,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
