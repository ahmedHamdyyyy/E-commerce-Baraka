import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../config/constants/constance.dart';
import '../../../core/services/api_services.dart';
import '../../../core/services/cache_services.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/utils.dart';
import '../data/repository.dart';
part 'state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repo) : super(const HomeState());
  final HomeRepository _repo;
  bool _isApiInit = false;
  bool _isCacheInit = false;

  void setApp(context) async {
    if (!_isCacheInit) {
      _isCacheInit = await getit<CacheServices>().init();
      if (!_isCacheInit) {
        return Utils.errorDialog(
          context,
          'error occurred while initialize cacheServices',
          onPressed: () => setApp(context),
        );
      }
    }
    //await getit<CacheServices>().shared.clear();
    //emit(state.copyWith(lang: _repo.lang(), theme: _repo.theme()));
    if (!_isApiInit) {
      _isApiInit = await getit<ApiServices>().init();
      if (!_isApiInit) {
        return Utils.errorDialog(
          context,
          'error occurred while initialize apiServices',
          onPressed: () => setApp(context),
        );
      }
    }
    final type = typeScreen();
   await Future.delayed(const Duration(milliseconds: 0),() => Navigator.pushNamedAndRemoveUntil(
       context, type == '' ?
   AppConst.signInScreen : type, (route) => false),);

    Utils.successSnackBar(context, "success");
  }

//await getit<CacheServices>().shared.clear();
  getTheme() {
    final theme = _repo.theme();
    emit(state.copyWith(theme: theme, themeStatus: Status.success));
  }

  void getLang() {}

  void setTheme(int theme) async {
    try {
      emit(state.copyWith(themeStatus: Status.loading));
      final themeResponse = theme == 0 ? 1 : 0;
      await _repo.setTheme(themeResponse);
      emit(state.copyWith(theme: themeResponse, themeStatus: Status.success));
    } catch (e) {
      _emitFailure(e);
    }
  }

  void setLang(String lang) {
    try {
      emit(state.copyWith(langStatus: Status.loading));
      final langResponse = lang == 'en' ? 'ar' : 'en';
      _repo.setLang(langResponse);
      emit(state.copyWith(lang: langResponse, langStatus: Status.success));
    } on Exception catch (e) {
      _emitFailure(e);
    }
  }

  String typeScreen() => _repo.type();

  void _emitFailure(Object e) => emit(state.copyWith(
      themeStatus: Status.error,
      msg: e.toString().length >= 100 ? 'error' : e.toString()));
}
