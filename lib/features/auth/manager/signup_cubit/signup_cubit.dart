import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtubefirebase/features/auth/data/models/user_model.dart';
import 'package:youtubefirebase/features/auth/manager/signup_cubit/signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupInitial());
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<void> signup({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(SignupLoading());
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential.user == null) {
        emit(SignupFailure('User creation failed'));
        return;
      }
      String uid = userCredential.user!.uid;
      await userCredential.user!.sendEmailVerification();
      UserModel user = UserModel(
        name: name,
        email: email,
        phone: phone,
        uid: uid,
      );
      await firebaseFirestore.collection('users').doc(uid).set(user.toMap());
      emit(SignupSuccess());
    } catch (e) {
      emit(SignupFailure(e.toString()));
    }
  }
}
