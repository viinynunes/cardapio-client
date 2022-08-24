import 'package:cardapio/modules/survey/domain/entities/survey.dart';
import 'package:cardapio/modules/survey/domain/entities/survey_response.dart';
import 'package:cardapio/modules/survey/errors/survey_errors.dart';
import 'package:dartz/dartz.dart';

abstract class ISurveyRepository {
  Future<Either<SurveyErrors, Survey?>> getSurvey();

  Future<Either<SurveyErrors, bool>> sendSurveyResponse(SurveyResponse response);
}
