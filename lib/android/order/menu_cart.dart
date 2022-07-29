import 'package:cardapio/android/controllers/bloc/events/menu_cart_events.dart';
import 'package:cardapio/android/controllers/bloc/menu_cart_bloc.dart';
import 'package:cardapio/android/controllers/bloc/states/menu_cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MenuCart extends StatefulWidget {
  const MenuCart({Key? key}) : super(key: key);

  @override
  State<MenuCart> createState() => _MenuCartState();
}

class _MenuCartState extends State<MenuCart> {
  late final MenuCartBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = MenuCartBloc();
    bloc.add(GetMenuCartList());
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Carrinho'),
          centerTitle: true,
          actions: [
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: const [
                    Text(
                      'Confirmar pedido',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(Icons.save),
                  ],
                ),
              ),
            ),
          ],
        ),
        body: BlocBuilder(
          bloc: bloc,
          builder: (context, state) {
            if (state is MenuCartLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is MenuCartErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 100,
                    ),
                    Text(
                      state.error.message,
                      style: const TextStyle(fontSize: 50),
                    ),
                  ],
                ),
              );
            }

            if (state is MenuCartSuccessState) {
              final menuItemCartList = state.menuItemCartList;

              return menuItemCartList.isEmpty
                  ? ListView.builder(
                      itemCount: menuItemCartList.length,
                      itemBuilder: (context, index) {
                        var item = menuItemCartList[index];

                        return Card(
                          child: Container(
                            height: size.height * 0.2,
                            margin: const EdgeInsets.all(16),
                            child: Row(
                              children: [
                                Flexible(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(item.imgUrl),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          item.name,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 22),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              bloc.add(
                                                  RemoveItemMenuFromCart(item));
                                            },
                                            child: const Text('Remover Item'))
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.shopping_cart_outlined,
                            size: 100,
                          ),
                          Text(
                            'Carrinho Vazio',
                            style: TextStyle(fontSize: 50),
                          ),
                        ],
                      ),
                    );
            }

            return Container();
          },
        ));
  }
}
