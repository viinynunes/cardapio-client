import 'package:cardapio/modules/survey/domain/entities/survey.dart';
import 'package:cardapio/modules/survey/domain/entities/survey_response.dart';
import 'package:cardapio/modules/survey/domain/repositories/i_survey_repository.dart';
import 'package:cardapio/modules/survey/errors/survey_errors.dart';
import 'package:cardapio/modules/survey/infra/datasources/i_survey_datasource.dart';
import 'package:cardapio/modules/survey/infra/models/survey_response_model.dart';
import 'package:dartz/dartz.dart';

class SurveyRepositoryImpl implements ISurveyRepository {
  final ISurveyDatasource _datasource;

  SurveyRepositoryImpl(this._datasource);

  @override
  Future<Either<SurveyErrors, Survey?>> getSurvey() async {
    try {
      final response = await _datasource.getSurvey();

      return Right(response);
    } on SurveyErrors catch (e) {
      return Left(e);
    } catch (e) {
      return Left(SurveyErrors('Uncaught error: ${e.toString()}'));
    }
  }

  @override
  Future<Either<SurveyErrors, bool>> sendSurveyResponse(
      SurveyResponse response) async {
    try {
      final result = await _datasource
          .sendSurveyResponse(SurveyResponseModel.fromSurveyResponse(response));

      return Right(result);
    } on SurveyErrors catch (e) {
      return Left(e);
    } catch (e) {
      return Left(SurveyErrors('Uncaught error: ${e.toString()}'));
    }
  }
}
