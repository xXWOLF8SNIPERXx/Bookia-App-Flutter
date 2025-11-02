import 'package:bookia/feature/auth/data/models/auth_params.dart';
import 'package:bookia/feature/auth/data/repo/auth_repo.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());

  var formKey = GlobalKey<FormState>();
  var usernameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmpasswordController = TextEditingController();

  register() async {
    emit(AuthLoadingState());

    var res = await AuthRepo.register(
      AuthParams(
        name: usernameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmPassword: confirmpasswordController.text,
      ),
    );

    if (res != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(message: 'Registeration Failed'));
    }
  }

  login() async {
    emit(AuthLoadingState());

    var res = await AuthRepo.login(
      AuthParams(
        email: emailController.text,
        password: passwordController.text,
      ),
    );

    if (res != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(message: 'Login Failed'));
    }
  }
}
