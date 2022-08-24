import 'package:cardapio/modules/login/domain/entities/user.dart';
import 'package:cardapio/modules/survey/domain/entities/survey.dart';

class SurveyResponse {
  String id;
  User user;
  double satisfaction;
  String description;
  Survey survey;

  SurveyResponse({required this.id, required this.user, required this.satisfaction, required this.description, required this.survey});
}
