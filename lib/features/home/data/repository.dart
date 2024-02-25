import '../../../core/error/error_handler.dart';
import 'data.dart';

class HomeRepository {
  HomeRepository(this._data, this._handler);
  final HomeData _data;
  final ErrorHandler _handler;
  String type() => _handler.normal(_isSignedIn());

  String _isSignedIn() => _data.isSignedIn() ? (_data.getType() ?? '') : '';

  int theme() => _data.checkTheme() ? _data.getTheme() ?? 0 : 0;
  Future setTheme(
    int theme,
  ) async =>
      await _data.setTheme(theme) ? null : throw Exception("failed");
  String lang() => _data.checkLang() ? _data.getLang() ?? 'en' : 'en';
  Future setLang(
    String lang,
  ) async =>
      await _data.setLang(lang) ? null : throw Exception("failed");
}
