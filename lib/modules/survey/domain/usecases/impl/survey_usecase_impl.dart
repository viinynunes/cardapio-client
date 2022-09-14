import 'package:cardapio/modules/survey/domain/entities/survey.dart';
import 'package:cardapio/modules/survey/domain/entities/survey_response.dart';
import 'package:cardapio/modules/survey/domain/repositories/i_survey_repository.dart';
import 'package:cardapio/modules/survey/domain/usecases/i_survey_usecase.dart';
import 'package:cardapio/modules/survey/errors/survey_errors.dart';
import 'package:dartz/dartz.dart';

class SurveyUsecaseImpl implements ISurveyUsecase {
  final ISurveyRepository _repository;

  SurveyUsecaseImpl(this._repository);

  @override
  Future<Either<SurveyErrors, Survey?>> getSurvey() {
    return _repository.getSurvey();
  }

  @override
  Future<Either<SurveyErrors, bool>> sendSurveyResponse(
      SurveyResponse response) async {

    if (response.satisfaction < 0){
      return Left(SurveyErrors('Satisfaction cannot be less then 0'));
    }
    if(response.client.id.isEmpty){
      return Left(SurveyErrors('Error getting user'));
    }

    return _repository.sendSurveyResponse(response);
  }
}
