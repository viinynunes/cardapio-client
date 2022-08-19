import 'package:cardapio/modules/home/presenter/pages/tiles/home_tile.dart';
import 'package:cardapio/modules/login/presenter/bloc/states/login_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../login/presenter/bloc/events/login_events.dart';
import '../../../login/presenter/bloc/login_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = Modular.get<LoginBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Escolha uma opção'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pushNamed('/cart/');
            },
            icon: const Icon(Icons.shopping_cart_outlined),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            bloc.add(UserLogoutEvent());
            Modular.to.pushNamed('/login/');
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
                      Modular.to.pushNamed('/menu/');
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  HomeTile(
                    title: 'Meus Pedidos',
                    icon: Icons.reorder,
                    onTap: () {
                      Modular.to.pushNamed('/order/');
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  HomeTile(
                    title: 'Pesquisa de Satisfação',
                    icon: Icons.star_rate,
                    onTap: () {},
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
                bloc: bloc,
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
                  bloc: bloc,
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
          )),
    );
  }
}
