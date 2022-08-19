import 'package:cardapio/modules/login/domain/usecases/impl/login_usecase_impl.dart';
import 'package:cardapio/modules/login/external/impl/firebase_datasource.dart';
import 'package:cardapio/modules/login/external/impl/hive_datasource.dart';
import 'package:cardapio/modules/login/infra/repositories/login_repository_impl.dart';
import 'package:cardapio/modules/login/presenter/bloc/login_bloc.dart';
import 'package:cardapio/modules/login/presenter/pages/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => HiveDatasource()),
        Bind((i) => FirebaseDatasource(i())),
        Bind((i) => LoginRepositoryImpl(i())),
        Bind((i) => LoginUsecaseImpl(i())),
        Bind((i) => LoginBloc(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const LoginPage()),
      ];
}
