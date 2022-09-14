import 'package:cardapio/modules/login/domain/entities/client.dart';
import 'package:cardapio/modules/survey/domain/entities/survey.dart';

class SurveyResponse {
  String id;
  Client client;
  double satisfaction;
  String description;
  Survey survey;

  SurveyResponse({required this.id, required this.client, required this.satisfaction, required this.description, required this.survey});
}
