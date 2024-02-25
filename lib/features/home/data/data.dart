import '../../../config/constants/constance.dart';
import '../../../core/services/cache_services.dart';

class HomeData {
  final CacheServices _cache;
  HomeData(this._cache);

  bool isSignedIn() => _cache.shared.containsKey(AppConst.type);
  String? getType() => _cache.shared.getString(AppConst.type);
  Future<bool> typeStore() async =>
      await _cache.shared.setString(AppConst.type, AppConst.customerScreen);
//
  bool checkTheme() => _cache.shared.containsKey(AppConst.theme);
  bool checkLang() => _cache.shared.containsKey(AppConst.lang);
  Future<bool> setTheme(int theme) async =>
      await _cache.shared.setInt(AppConst.theme, theme);
  int? getTheme() => _cache.shared.getInt(AppConst.theme);
  Future<bool> setLang(String lang) async =>
      await _cache.shared.setString(AppConst.lang, lang);
  String? getLang() => _cache.shared.getString(AppConst.lang);
}
