import 'package:cardapio/modules/survey/infra/models/survey_response_model.dart';

import '../models/survey_model.dart';

abstract class ISurveyDatasource {
  Future<SurveyModel?> getSurvey();

  Future<bool> sendSurveyResponse(SurveyResponseModel response);
}
