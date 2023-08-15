import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:p_1/login/model.dart';

import '../repository/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginStateImpl> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    // on<LoginLoadingEvent>((event, emit) => emit(state.copyWith(
    //       status: LoginStatu.LOADING,
    //     )));
    on<LogedINEvent>((event, emit) async {
      emit(state.copyWith(
        status: LoginStatu.LOADING,
      ));
      try {
        dynamic resp = await LoginRepo.login(
            username: event.username, password: event.password);
        Model model = Model();

        if (resp != null) {
          model = Model.fromJson(resp);

          emit(state.copyWith(
            status: LoginStatu.SUCCESS,
            authModel: model,
          ));
        } else {
          emit(state.copyWith(
            status: LoginStatu.FAILURE,
          ));
        }
      } catch (e) {
        emit(state.copyWith(
          status: LoginStatu.FAILURE,
        ));
      }
    });
  }
}
