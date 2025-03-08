import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_attendance_system/core/models/user_model.dart';
import 'package:gps_attendance_system/core/services/user_services.dart';
import 'package:meta/meta.dart';
part 'auth_states.dart';

StreamSubscription<User?>? authSubscription;

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitial()) {
    authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        // final user = FirebaseAuth.instance.currentUser;
        emit(Authenticated(user.uid));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  // get instance of cubit
  static AuthCubit get(BuildContext context) => BlocProvider.of(context);
  bool loginPasswordSecure = false;
  IconData loginIcon = Icons.visibility_outlined;

//-- Login method --//
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      // login using firebase auth
      final user = await UserService.signInWithEmailAndPassword(
        email,
        password,
      );
      // save token in shared prefs
      // await SharedPrefsService.saveStringData(
      //   key: AppStringEn.tokenKey,
      //   value: user!.uid,
      // );
      if (user != null) {
        emit(Authenticated(user.uid));
      } else {
        emit(Unauthenticated());
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(AuthError(message: 'No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(AuthError(message: 'Wrong password provided for that user.'));
      }
    } catch (e) {
      emit(AuthError(message: 'An error occurred'));
    }
  }

//-- Sign up method --//
  Future<void> signUp({
    required String email,
    required String password,
    required UserModel userModel,
  }) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String uid = credential.user!.uid;
// save user data in firebase
      UserModel newUser = UserModel(
        name: userModel.name,
        email: email,
        role: userModel.role,
        // uid: uid,
        contactNumber: userModel.contactNumber,
        isOnLeave: userModel.isOnLeave,
        position: userModel.position,
      );
      await UserService.addUser(uid, newUser);
      emit(AccountCreated());
    } catch (e) {
      emit(AuthError(message: 'There was an error creating the account'));
    }
  }

  // Logout method
  Future<void> logout() async {
    await UserService.signOut();
    emit(Unauthenticated());
  }

  @override
  Future<void> close() {
    authSubscription?.cancel();
    return super.close();
  }
}
