import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../config/constants/constance.dart';
import '../../../models/admin.dart';
import '../../../models/user.dart';
import '../data/repository.dart';
part 'state.dart';

class AdminCubit extends Cubit<AdminState> {
  AdminCubit(this._repo) : super(const AdminState());
  final AdminRepository _repo;
  void signIn(String email, String password) async {
    try {
      emit(state.copyWith(signInState: Status.loading));
      final admin = await _repo.signIn(email, password);
      emit(state.copyWith(
          admin: admin, msg: 'success process', signInState: Status.success));
    } on Exception catch (e) {
      emit(state.copyWith(signInState: Status.error, msg: e.toString()));
    }
  }

  void addUser(UserModel userModel, String password) async {
    try {
      emit(state.copyWith(addUserState: Status.loading));
      final user = await _repo.addUser(userModel, password);
      emit(state.copyWith(
          user: user, msg: ' add user success ', addUserState: Status.success));

      debugPrint(state.msg);
    } on Exception catch (e) {
      emit(state.copyWith(addUserState: Status.error, msg: e.toString()));
    }
  }

  void addAdmin(AdminModel userModel, String password) async {
    try {
      emit(state.copyWith(addUserState: Status.loading));
      final user = await _repo.addAdmin(userModel, password);
      emit(state.copyWith(
          admin: user,
          msg: ' add admin success ',
          addUserState: Status.success));
      debugPrint(state.msg);
    } on Exception catch (e) {
      emit(state.copyWith(addUserState: Status.error, msg: e.toString()));
      debugPrint(state.msg);

      debugPrint("121212+++++++");
    }
  }

  void getUsers() async {
    emit(state.copyWith(
      getAllUsersState: Status.loading,
    ));
    try {
      final users = await _repo.getUsers();
      emit(state.copyWith(
          getAllUsersState: Status.success,
          users: users,
          msg: "get all users"));
    } on FirebaseException {
      emit(state.copyWith(
        getAllUsersState: Status.error,
      ));
    }
  }

  void deleteUser(String id) async {
    emit(state.copyWith(deleteUserState: Status.loading));
    await _repo.deleteUser(id).then((value) {
      final List<UserModel> userList = List.from(state.users);
      userList.removeWhere((element) => element.id == id);
      emit(
        state.copyWith(
          users: userList,
          deleteUserState: Status.success,
          msg: "delete success",
        ),
      );
    }).catchError((e) {
      emit(state.copyWith(
        deleteUserState: Status.error,
        msg: "error delete",
      ));
    });
  }

  void resetPassword(String email) async {
    try {
      emit(state.copyWith(
        resetPasswordState: Status.loading,
      ));
      final response = await _repo.resetPassword(email);
      if (response == "Password reset email sent") {
        emit(state.copyWith(resetPasswordState: Status.success, msg: response));
      } else {
        emit(state.copyWith(
          resetPasswordState: Status.error,
          msg: response,
        ));
      }
    } on FirebaseException catch (e) {
      emit(state.copyWith(resetPasswordState: Status.error, msg: e.code));
    }
  }
}
