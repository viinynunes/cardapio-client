import 'package:cardapio/modules/survey/domain/entities/survey_response.dart';
import 'package:cardapio/modules/survey/infra/models/survey_model.dart';

import '../../../login/infra/models/user_model.dart';

class SurveyResponseModel extends SurveyResponse {
  SurveyResponseModel({
    required super.id,
    required super.user,
    required super.satisfaction,
    required super.description,
    required super.survey,
  });

  SurveyResponseModel.fromSurveyResponse(SurveyResponse response)
      : super(
            id: response.id,
            user: response.user,
            satisfaction: response.satisfaction,
            description: response.description,
            survey: response.survey);

  SurveyResponseModel.fromMap(Map<String, dynamic> map)
      : super(
            id: map['id'],
            user: UserModel.fromMap(map['user']),
            satisfaction: map['satisfaction'],
            description: map['description'],
            survey: SurveyModel.fromMap(map['survey']));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user': UserModel.fromUser(user: user).toMap(),
      'satisfaction': satisfaction,
      'description': description,
      'survey': SurveyModel.fromSurvey(survey).toMap(),
    };
  }
}
