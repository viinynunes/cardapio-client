import 'package:cardapio/android/controllers/menu_cart_controller.dart';
import 'package:flutter/material.dart';

class MenuCart extends StatefulWidget {
  const MenuCart({Key? key}) : super(key: key);

  @override
  State<MenuCart> createState() => _MenuCartState();
}

class _MenuCartState extends State<MenuCart> {
  final controller = MenuCartController();

  @override
  void initState() {
    super.initState();

    controller.getList();
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
            onTap: (){

            },
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
      body: controller.menuItemCartList.isNotEmpty
          ? ListView.builder(
              itemCount: controller.menuItemCartList.length,
              itemBuilder: (context, index) {
                var item = controller.menuItemCartList[index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  item.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 22),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        controller.removeMenuItem(item);
                                      });
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
            ),
    );
  }
}
