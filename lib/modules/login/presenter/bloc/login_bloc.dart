import 'package:bloc/bloc.dart';
import 'package:cardapio/modules/login/presenter/bloc/events/login_events.dart';
import 'package:cardapio/modules/login/presenter/bloc/states/login_states.dart';
import 'package:cardapio/modules/login/domain/usecases/i_login_usecase.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final ILoginUsecase usecase;

  LoginBloc(this.usecase) : super(LoginIdleState()) {
    on<UserLoginEvent>((event, emit) async {
      emit(LoginLoadingState());

      final result = await usecase.login(event.email, event.password);

      result.fold((l) => emit(LoginErrorState(l.message)),
          (r) => emit(LoginSuccessState(r)));
    });
  }
}
