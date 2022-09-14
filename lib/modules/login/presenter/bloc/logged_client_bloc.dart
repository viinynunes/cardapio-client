import 'package:bloc/bloc.dart';
import 'package:cardapio/modules/login/domain/usecases/i_logged_client_usecase.dart';
import 'package:cardapio/modules/login/presenter/bloc/events/logged_user_events.dart';
import 'package:cardapio/modules/login/presenter/bloc/states/logged_user_states.dart';

class LoggedClientBloc extends Bloc<LoggedClientEvents, LoggedClientStates> {
  final ILoggedClientUsecase usecase;

  LoggedClientBloc(this.usecase) : super(LoggedClientIdleState()) {
    on<GetLoggedClientEvent>((event, emit) async {
      emit(LoggedClientLoadingState());

      final result = await usecase.getLoggedUser();

      result.fold((l) => emit(LoggedClientErrorState(l)),
          (r) => emit(LoggedClientSuccessState(r)));
    });
  }
}
