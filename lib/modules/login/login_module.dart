import 'package:cardapio/modules/login/presenter/bloc/login_bloc.dart';
import 'package:cardapio/modules/login/presenter/pages/login_page.dart';
import 'package:cardapio/modules/login/domain/repositories/mock_login_repository.dart';
import 'package:cardapio/modules/login/domain/usecases/impl/login_usecase_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => MockLoginRepository()),
        Bind.factory((i) => LoginUsecaseImpl(i())),
        Bind.singleton((i) => LoginBloc(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const LoginPage()),
      ];
}
