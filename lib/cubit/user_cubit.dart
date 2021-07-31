import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kurir_zahra/helper/helper.dart';
import 'package:kurir_zahra/models/models.dart';
import 'package:kurir_zahra/services/services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> signIn(String email, String password) async {
    ApiReturnValue result = await UserServices.signIn(email, password);

    if (result.value != null) {
      emit(UserActionSuccess('Login berhasil, selamat datang'));
    } else {
      emit(UserActionFailed(result.message!));
    }
  }

  Future<void> getUserExisting() async {
    UserLocalTable userLocalTable = UserLocalTable();
    User? user = await userLocalTable.getUser();

    if (user != null) {
      emit(UserLoadedSuccess(user));
    } else {
      emit(UserActionFailed(
          'User tidak tersedia silahkan login terlebih dahulu'));
    }
  }

  Future<void> logoutUser() async {
    UserLocalTable userLocalTable = UserLocalTable();
    int result = await userLocalTable.delete();

    if (result > 0) {
      emit(UserActionSuccess('Terimakasih, sampai jumpa !!!'));
    } else {
      emit(UserActionFailed('Logout gagal, silahkan coba lagi'));
    }
  }

  Future<void> updateProfile(User user) async {
    bool result = await UserServices.update(user);

    if (result) {
      emit(UserActionSuccess('Profile anda berhasil diperbaharui'));
    } else {
      emit(UserActionFailed('Profile anda gagal diperbaharui'));
    }
  }

  Future<void> updatePassword(
      String email, String newPassword, String oldPassword) async {
    bool result = await UserServices.change(email, newPassword, oldPassword);

    if (result) {
      emit(UserActionSuccess('Password anda berhasil diperbaharui'));
    } else {
      emit(UserActionFailed('Password anda gagal diperbaharui'));
    }
  }

  Future<void> getUser() async {
    UserLocalTable userLocalTable = UserLocalTable();
    User? user = await userLocalTable.getUser();

    if (user != null) {
      emit(UserLoadedSuccess(user));
    } else {
      emit(UserActionFailed('Data user kosong !!!'));
    }
  }

  Future<void> updatePhotoProfile(File file, User user) async {
    bool result = await UserServices.updatePhotoProfil(file, user);

    if (result) {
      emit(UserActionSuccess('Profile anda berhasil diperbaharui'));
    } else {
      emit(UserActionFailed('Profile gagal diperbaharui !!!'));
    }
  }
}
