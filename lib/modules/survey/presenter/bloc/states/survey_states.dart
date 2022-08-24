import 'package:cardapio/modules/survey/domain/entities/survey.dart';
import 'package:cardapio/modules/survey/errors/survey_errors.dart';

abstract class SurveyStates {}

class SurveyIdleState implements SurveyStates {}

class SurveyLoadingState implements SurveyStates {}

class SurveySuccessState implements SurveyStates {
  final Survey survey;

  SurveySuccessState(this.survey);
}

class SurveyEmptyState implements SurveyStates {}

class SurveySendResponseSuccessState implements SurveyStates {}

class SurveyErrorState implements SurveyStates {
  final SurveyErrors error;

  SurveyErrorState(this.error);
}
