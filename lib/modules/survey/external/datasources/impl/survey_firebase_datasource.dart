import 'package:cardapio/modules/login/infra/datasources/i_logged_client_datasource.dart';
import 'package:cardapio/modules/survey/errors/survey_errors.dart';
import 'package:cardapio/modules/survey/infra/datasources/i_survey_datasource.dart';
import 'package:cardapio/modules/survey/infra/models/survey_model.dart';
import 'package:cardapio/modules/survey/infra/models/survey_response_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SurveyFirebaseDatasource implements ISurveyDatasource {
  final ILoggedClientDatasource loggedClientDatasource;

  SurveyFirebaseDatasource(this.loggedClientDatasource);

  final _surveyCollection = FirebaseFirestore.instance.collection('survey');

  @override
  Future<SurveyModel?> getSurvey() async {
    final client = await loggedClientDatasource.getLoggedClient();

    final surveySnap =
    await _surveyCollection.where('enabled', isEqualTo: true).get();


    if (surveySnap.docs.length > 1) {
      throw SurveyErrors('More then one active survey');
    }

    final survey = SurveyModel.fromMap(surveySnap.docs.first.data());

    final responseSnap = await _surveyCollection.doc(survey.id).collection('responses').where('client.id', isEqualTo: client.id).get();

    if(responseSnap.docs.isNotEmpty){
      return null;
    }

    return survey;
  }

  @override
  Future<bool> sendSurveyResponse(SurveyResponseModel response) async {
    _surveyCollection
        .doc(response.survey.id)
        .collection('responses')
        .add(response.toMap())
        .then((value) async {
      response.id = value.id;

      _surveyCollection
          .doc(response.survey.id)
          .collection('responses')
          .doc(response.id)
          .update(response.toMap());
    });

    return true;
  }
}
