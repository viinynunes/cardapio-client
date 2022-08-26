import 'package:cardapio/modules/survey/presenter/bloc/events/survey_events.dart';
import 'package:cardapio/modules/survey/presenter/bloc/states/survey_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lottie/lottie.dart';

import '../bloc/survey_bloc.dart';

class SurveyPage extends StatefulWidget {
  const SurveyPage({Key? key}) : super(key: key);

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> with TickerProviderStateMixin {
  final bloc = Modular.get<SurveyBloc>();

  late AnimationController _surveyResponseAniController;
  final _descriptionController = TextEditingController();
  double rating = 0;

  @override
  void initState() {
    super.initState();
    _surveyResponseAniController = AnimationController(vsync: this);
    _surveyResponseAniController.duration = const Duration(seconds: 2);

    bloc.add(SurveyGetSurveyEvent());
  }

  @override
  void dispose() {
    _surveyResponseAniController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pesquisa de Satisfação'),
        centerTitle: true,
      ),
      body: BlocBuilder<SurveyBloc, SurveyStates>(
        bloc: bloc,
        builder: (context, state) {
          if (state is SurveyLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is SurveyErrorState) {
            return Center(
              child: Text(state.error.message),
            );
          }

          if (state is SurveyEmptyState) {
            return const Center(
              child: Text('Nenhuma Pesquisa disponivel'),
            );
          }

          if (state is SurveySuccessState) {
            var survey = state.survey;

            return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: Text(survey.title),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 2,
                    child: Text(survey.description),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 3,
                    child: RatingBar.builder(itemBuilder: (context, __) {
                      return const Icon(
                        Icons.star,
                        color: Colors.amber,
                      );
                    }, onRatingUpdate: (e) {
                      rating = e;
                    }),
                  ),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 3,
                    child: TextField(
                      controller: _descriptionController,
                      expands: true,
                      maxLines: null,
                      decoration: const InputDecoration(
                          labelText: 'Descrição',
                          hintText:
                              'Escreva algo que a equipe deve saber ou melhorar'),
                      onSubmitted: (e) {},
                    ),
                  ),
                  Expanded(child: Container()),
                  Flexible(
                    fit: FlexFit.tight,
                    flex: 1,
                    child: SizedBox(
                      width: size.width * 0.9,
                      child: ElevatedButton(
                        onPressed: () {
                          bloc.add(SurveySendSurveyResponse(
                              rating, _descriptionController.text, survey));
                        },
                        child: const Text('Enviar'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          if (state is SurveySendResponseSuccessState) {
            _surveyResponseAniController.addStatusListener((status) {
              status == AnimationStatus.completed
                  ? Modular.to.pushNamed('../home/')
                  : null;
            });

            _surveyResponseAniController.forward();

            return Scaffold(
              backgroundColor: Colors.white,
              body: Center(
                child: Lottie.asset(
                    'assets/lottie/survey-response-confirmation.json',
                    controller: _surveyResponseAniController),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }
}
