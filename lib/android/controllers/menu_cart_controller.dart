import '../../modules/week_menu/domain/entities/item_menu.dart' as item;

class MenuCartController {
  List<item.ItemMenu> menuItemCartList = [];

  removeMenuItem(item.ItemMenu item){
    menuItemCartList.remove(item);
  }

  Future getList() async {
    for (int i = 1; i <= 10; i++) {
      menuItemCartList.add(
        item.ItemMenu(
            'Arroz com Feijão e Batata Frita $i',
            'comida feita com o ingrediente de numero ${i * 35}, recheado com o molho de numero ${i * 17} e também temperado com ervas número ${i * 23}',
            'https://portal.fgv.br/sites/portal.fgv.br/files/'
                'styles/noticia_geral/public/noticias/set/17/'
                'prato-feito.jpg?itok=klqGuxxN&c=33313733cdad61e4bd51beabb4a84531'),
      );
    }
  }
}