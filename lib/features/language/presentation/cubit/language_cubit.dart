import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_language_usecase.dart';
import '../../domain/usecases/save_language_usecase.dart';
import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  final GetLanguageUseCase getLanguage;
  final SaveLanguageUseCase saveLanguage;

  LanguageCubit({
    required this.getLanguage,
    required this.saveLanguage,
  }) : super(const LanguageState(Locale('en')));

  Future<void> loadSavedLanguage() async {
    final code = await getLanguage();
    emit(LanguageState(Locale(code)));
  }


  Future<void> changeLanguage(String code) async {
    await saveLanguage(code);
    emit(LanguageState(Locale(code)));
  }
}