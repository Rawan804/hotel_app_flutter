import 'package:bloc/bloc.dart';
import 'package:hotel_app/core/services.dart';
import 'package:hotel_app/features/Auth/domain/usecases/%20loginUseCase.dart';

import 'package:meta/meta.dart';

import '../../domain/entities/User.dart';
import '../../domain/usecases/ loginUseCase.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {

  final LoginUseCase loginUseCase;

  LoginCubit(this.loginUseCase)
      : super(LoginInitial());

  Future<void>login(String email,String password)async{
    emit(LoginLoading());
    final result=await loginUseCase(email,password);
    result.fold((failure){
      emit(LoginFailure(failure.message));
    }, (user) {
      emit(LoginSuccess(user));
      NotificationService.sendCurrentTokenToBackend();
    });}

}