import '../../../domain/entities/survey.dart';

abstract class SurveyEvents {}

class SurveyGetSurveyEvent implements SurveyEvents {}

class SurveySendSurveyResponse implements SurveyEvents {
  final double rating;
  final String description;
  final Survey survey;

  SurveySendSurveyResponse(this.rating, this.description, this.survey);
}
