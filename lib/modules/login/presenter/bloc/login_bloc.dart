import 'package:bloc/bloc.dart';
import 'package:cardapio/modules/login/domain/usecases/i_login_usecase.dart';
import 'package:cardapio/modules/login/presenter/bloc/events/login_events.dart';
import 'package:cardapio/modules/login/presenter/bloc/states/login_states.dart';

class LoginBloc extends Bloc<LoginEvents, LoginStates> {
  final ILoginUsecase usecase;

  LoginBloc(this.usecase) : super(LoginIdleState()) {
    on<ClientLoginEvent>((event, emit) async {
      emit(LoginLoadingState());

      final result = await usecase.login(event.email, event.password);

      result.fold(
          (l) => emit(LoginErrorState(l)), (r) => emit(LoginSuccessState(r)));
    });

    on<ClientLogoutEvent>((event, emit) async {
      emit(LoginLoadingState());
      final result = await usecase.logout();

      result.fold((l) => emit(LoginErrorState(l)),
          (r) => emit(LoginLogoutSuccessState()));
    });
  }
}
