import 'package:cardapio/modules/survey/domain/entities/survey_response.dart';
import 'package:cardapio/modules/survey/infra/models/survey_model.dart';

import '../../../login/infra/models/client_model.dart';

class SurveyResponseModel extends SurveyResponse {
  SurveyResponseModel({
    required super.id,
    required super.client,
    required super.satisfaction,
    required super.description,
    required super.survey,
  });

  SurveyResponseModel.fromSurveyResponse(SurveyResponse response)
      : super(
            id: response.id,
            client: response.client,
            satisfaction: response.satisfaction,
            description: response.description,
            survey: response.survey);

  SurveyResponseModel.fromMap(Map<String, dynamic> map)
      : super(
            id: map['id'],
            client: ClientModel.fromMap(map['client']),
            satisfaction: map['satisfaction'],
            description: map['description'],
            survey: SurveyModel.fromMap(map['survey']));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'client': ClientModel.fromClient(client: client).toMap(),
      'satisfaction': satisfaction,
      'description': description,
      'survey': SurveyModel.fromSurvey(survey).toMap(),
    };
  }
}
