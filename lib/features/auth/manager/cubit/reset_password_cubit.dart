import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:youtubefirebase/features/auth/manager/cubit/reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(ResetPasswordInitial());
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<void> resetpassword(String email) async {
    emit(ResetPasswordLoading());
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      emit(ResetPasswordSuccess());
    } on FirebaseAuthException catch (e) {
      emit(ResetPasswordFailure(e.message ?? 'An unknown error occurred'));
    } catch (e) {
      emit(ResetPasswordFailure(e.toString()));
    }
  }
}
