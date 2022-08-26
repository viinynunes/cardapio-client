import 'package:bloc/bloc.dart';
import 'package:cardapio/modules/login/domain/usecases/i_logged_user_usecase.dart';
import 'package:cardapio/modules/login/presenter/bloc/events/logged_user_events.dart';
import 'package:cardapio/modules/login/presenter/bloc/states/logged_user_states.dart';

class LoggedUserBloc extends Bloc<LoggedUserEvents, LoggedUserStates> {
  final ILoggedUserUsecase usecase;

  LoggedUserBloc(this.usecase) : super(LoggedUserIdleState()) {
    on<GetLoggedUserEvent>((event, emit) async {
      emit(LoggedUserLoadingState());

      final result = await usecase.getLoggedUser();

      result.fold((l) => emit(LoggedUserErrorState(l)),
          (r) => emit(LoggedUserSuccessState(r)));
    });
  }
}
