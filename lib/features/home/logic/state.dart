part of 'cubit.dart';

class HomeState extends Equatable {
  final int theme;
  final String msg;
  final String lang;
  final Status themeStatus;
  final Status langStatus;

  const HomeState({
    this.theme = 0,
    this.msg = '',
    this.lang = 'en',
    this.themeStatus = Status.initial,
    this.langStatus = Status.initial,
  });

  HomeState copyWith({
    int? theme,
    String? msg,
    String? lang,
    Status? themeStatus,
    Status? langStatus,
  }) =>
      HomeState(
        theme: theme ?? this.theme,
        msg: msg ?? this.msg,
        lang: lang ?? this.lang,
        themeStatus: themeStatus ?? this.themeStatus,
        langStatus: langStatus ?? this.langStatus,
      );

  @override
  List<Object> get props => [
        theme,
        msg,
        lang,
        themeStatus,
        langStatus,
      ];
}
