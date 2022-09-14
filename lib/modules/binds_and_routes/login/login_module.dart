import 'package:cardapio/modules/binds_and_routes/login/navigation/navigation_module.dart';
import 'package:cardapio/modules/login/domain/usecases/impl/logged_client_usecase_impl.dart';
import 'package:cardapio/modules/login/domain/usecases/impl/login_usecase_impl.dart';
import 'package:cardapio/modules/login/external/impl/login_firebase_datasource.dart';
import 'package:cardapio/modules/login/external/impl/login_shared_preferences_datasource.dart';
import 'package:cardapio/modules/login/infra/repositories/logged_client_repository_impl.dart';
import 'package:cardapio/modules/login/infra/repositories/login_repository_impl.dart';
import 'package:cardapio/modules/login/presenter/bloc/logged_client_bloc.dart';
import 'package:cardapio/modules/login/presenter/bloc/login_bloc.dart';
import 'package:cardapio/modules/login/presenter/pages/login_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginModule extends Module {
  @override
  List<Bind> get binds => [
        //Offline Login Dependencies
        Bind((i) => LoginSharedPreferencesDatasource()),
        Bind((i) => LoggedClientRepositoryImpl(i())),
        Bind((i) => LoggedClientUsecaseImpl(i())),
        Bind((i) => LoggedClientBloc(i())),

        //Online Login Dependencies
        Bind((i) => LoginFirebaseDatasource(i())),
        Bind((i) => LoginRepositoryImpl(i())),
        Bind((i) => LoginUsecaseImpl(i())),
        Bind((i) => LoginBloc(i()))
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, __) => const LoginPage()),
        ModuleRoute('/navigation/', module: NavigationModule()),
      ];
}
