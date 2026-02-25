import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:youtubefirebase/core/share_pres.dart';
import 'package:youtubefirebase/features/auth/manager/login_cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await CacheHelper.saveLogin();
      emit(LoginSuccess());
    } on FirebaseAuthException catch (e) {
      emit(LoginFailure(e.message ?? 'An unknown error occurred'));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
