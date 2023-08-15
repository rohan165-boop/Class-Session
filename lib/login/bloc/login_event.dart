// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginEvent {}

class LogedINEvent extends LoginEvent {
  final String username;
  final String password;
  LogedINEvent({
    required this.username,
    required this.password,
  });
}
