import 'package:bloc/bloc.dart';

import 'bottombar_state.dart';


class BottomNavigationCubit extends Cubit<BottomNavigationState> {


  BottomNavigationCubit() : super(BottomNavigationInitial(2)); // القيمة الابتدائية هي 2

  void changeIndex(int newIndex) {
    emit(BottomNavigationSelected(newIndex));
  }
}
