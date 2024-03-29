import 'package:cardapio/modules/menu/domain/entities/item_menu.dart';
import 'package:flutter/material.dart';

class CartTile extends StatelessWidget {
  const CartTile(
      {Key? key, required this.item, required this.removeItemButtonAction})
      : super(key: key);

  final ItemMenu item;
  final VoidCallback removeItemButtonAction;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
                  borderRadius: BorderRadius.circular(16),
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
                    Flexible(
                      flex: 3,
                      child: Text(
                        item.name,
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        style: const TextStyle(fontSize: 19),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: ElevatedButton(
                          onPressed: removeItemButtonAction,
                          child: const Text('Remover Item')),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
