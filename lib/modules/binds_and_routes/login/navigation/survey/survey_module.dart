import 'package:cardapio/modules/survey/domain/usecases/impl/survey_usecase_impl.dart';
import 'package:cardapio/modules/survey/external/datasources/impl/survey_firebase_datasource.dart';
import 'package:cardapio/modules/survey/infra/repositories/survey_repository_impl.dart';
import 'package:cardapio/modules/survey/presenter/bloc/survey_bloc.dart';
import 'package:cardapio/modules/survey/presenter/pages/survey_page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SurveyModule extends Module {
  @override
  List<Bind> get binds => [
        Bind((i) => SurveyFirebaseDatasource(i())),
        Bind((i) => SurveyRepositoryImpl(i())),
        Bind((i) => SurveyUsecaseImpl(i())),
        Bind((i) => SurveyBloc(i(), i()))
      ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (_, __) => const SurveyPage()),

  ];
}
