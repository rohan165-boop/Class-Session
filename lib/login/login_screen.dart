import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'sceen_two.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _user = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.status == LoginStatu.FAILURE
            ? const Scaffold(
                body: Center(
                  child: Text("Failed To Log In"),
                ),
              )
            : (state.status == LoginStatu.INITIAL ||
                    state.status == LoginStatu.LOADING)
                ? Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 100,
                          ),
                          TextFormField(
                            controller: _user,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _password,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          BlocConsumer<LoginBloc, LoginState>(
                            listener: (context, state) {
                              if (state.status == LoginStatu.SUCCESS) {
                                log("Success message");
                                // Navigator.of(context).push(MaterialPageRoute(
                                //     builder: (context) => ScreenTwo(
                                //           model: state.authModel,
                                //         )));
                              }
                            },
                            builder: (context, status) {
                              return Column(
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<LoginBloc>().add(
                                            LogedINEvent(
                                              username: _user.text.trim(),
                                              password: _password.text.trim(),
                                            ),
                                          );
                                    },
                                    child: status.status == LoginStatu.LOADING
                                        ? const CircularProgressIndicator
                                            .adaptive()
                                        : const Text("Log In"),
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  )
                : Scaffold(
                    body: Column(
                      children: [
                        Text(state.authModel.firstName ?? ""),
                        Text(state.authModel.email ?? ""),
                        Text(state.authModel.gender ?? ""),
                        Text(state.authModel.lastName ?? ""),
                        Text(state.authModel.username ?? ""),
                        Text(state.authModel.token ?? ""),
                      ],
                    ),
                  );
      },
    );
  }
}
