import 'package:bloc/bloc.dart';
import 'package:hotel_app/features/Auth/domain/usecases/logoutUseCase.dart';
import 'package:meta/meta.dart';
import 'logout_state.dart';
class LogoutCubit extends Cubit<LogoutState> {
  final Logoutusecase logoutusecase;
  LogoutCubit(this.logoutusecase) : super(LogoutInitial());
  Future<void>logout()async{
    emit(LogoutLoading());
    final result=await logoutusecase();
    result.fold((failure){
      emit(LogoutFailure(failure.message));
    }, (user) {
      emit(LogoutSuccess("Logout Success"));
    });}
}
