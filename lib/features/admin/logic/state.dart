part of 'cubit.dart';

class AdminState extends Equatable {
  final String msg;
  final bool isResetEmailSent;
  final Status signUpState;
  final Status signInState;
  final Status addUserState;
  final Status deleteUserState;
  final Status getAllUsersState;
  final Status resetPasswordState;
  final AdminModel admin;
  final UserModel user;
  final List<UserModel> users;

  const AdminState({
    this.msg = '',
    this.isResetEmailSent=false,
    this.signUpState = Status.initial,
    this.addUserState = Status.initial,
    this.signInState = Status.initial,
    this.deleteUserState = Status.initial,
    this.getAllUsersState = Status.initial,
    this.resetPasswordState = Status.initial,
    this.admin = AdminModel.non,
    this.user = UserModel.non,
    this.users = const[],
  });

  AdminState copyWith({
    String? msg,
    Status? signUpState,
    bool? isResetEmailSent,
    Status? signInState,
    Status? addUserState,
    Status? getAllUsersState,
    Status? resetPasswordState,
    Status? deleteUserState,

    AdminModel? admin,
    UserModel? user,
    List<UserModel>? users,
  }) =>
      AdminState(
        msg: msg ?? this.msg,
        signUpState: signUpState ?? this.signUpState,
        resetPasswordState: resetPasswordState ?? this.resetPasswordState,
        getAllUsersState: getAllUsersState ?? this.getAllUsersState,
        signInState: signInState ?? this.signInState,
        addUserState: addUserState ?? this.addUserState,
        deleteUserState: deleteUserState ?? this.deleteUserState,
        users: users??this.users,
        admin: admin ?? this.admin,
        isResetEmailSent: isResetEmailSent ?? this.isResetEmailSent,
        user: user ?? this.user,
      );

  @override
  List<Object> get props => [
    msg,
    signUpState,
    signInState,
    resetPasswordState,
    admin,
    users,
    deleteUserState,
    addUserState,user,
    getAllUsersState,

  ];
}
