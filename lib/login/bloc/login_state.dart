// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

enum LoginStatu { INITIAL, LOADING, SUCCESS, FAILURE }

abstract class LoginState {
  final LoginStatu status;
  final Model authModel;
  LoginState({
    required this.status,
    required this.authModel,
  });
}

class LoginStateImpl extends LoginState {
  LoginStateImpl({
    required super.authModel,
    required super.status,
  });

  LoginStateImpl copyWith({
    LoginStatu? status,
    Model? authModel,
  }) {
    return LoginStateImpl(
      status: status ?? this.status,
      authModel: authModel ?? this.authModel,
    );
  }
}

class LoginInitial extends LoginStateImpl {
  LoginInitial()
      : super(
          status: LoginStatu.INITIAL,
          authModel: Model(),
        );
}
