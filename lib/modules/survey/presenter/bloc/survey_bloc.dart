import 'package:bloc/bloc.dart';
import 'package:cardapio/modules/login/domain/entities/user.dart';
import 'package:cardapio/modules/survey/domain/entities/survey_response.dart';
import 'package:cardapio/modules/survey/errors/survey_errors.dart';
import 'package:cardapio/modules/survey/presenter/bloc/events/survey_events.dart';
import 'package:cardapio/modules/survey/presenter/bloc/states/survey_states.dart';

import '../../../login/domain/usecases/i_logged_user_usecase.dart';
import '../../domain/usecases/i_survey_usecase.dart';

class SurveyBloc extends Bloc<SurveyEvents, SurveyStates> {
  final ISurveyUsecase surveyUsecase;
  final ILoggedUserUsecase loggedUserUsecase;

  SurveyBloc(this.surveyUsecase, this.loggedUserUsecase)
      : super(SurveyIdleState()) {
    on<SurveyGetSurveyEvent>((event, emit) async {
      emit(SurveyLoadingState());

      final result = await surveyUsecase.getSurvey();

      result.fold((l) => emit(SurveyErrorState(l)), (r) {
        r == null ? emit(SurveyEmptyState()) : emit(SurveySuccessState(r));
      });
    });

    on<SurveySendSurveyResponse>((event, emit) async {
      emit(SurveyLoadingState());

      final loggedResult = await loggedUserUsecase.getLoggedUser();
      late User user;

      loggedResult.fold((l) {
        emit(SurveyErrorState(SurveyErrors(l.message)));
      }, (r) async {
        user = r;
      });

      final response = SurveyResponse(
          id: 'id',
          user: user,
          satisfaction: event.rating,
          description: event.description,
          survey: event.survey);

      final result = await surveyUsecase.sendSurveyResponse(response);

      result.fold((l) => emit(SurveyErrorState(l)),
          (r) => emit(SurveySendResponseSuccessState()));
    });
  }
}
