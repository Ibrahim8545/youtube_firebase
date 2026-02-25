import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtubefirebase/core/custom_button.dart';
import 'package:youtubefirebase/core/custom_snack_bar.dart';
import 'package:youtubefirebase/core/custom_textformfield.dart';
import 'package:youtubefirebase/core/utils/colors.dart';
import 'package:youtubefirebase/features/auth/manager/cubit/reset_password_cubit.dart';
import 'package:youtubefirebase/features/auth/manager/cubit/reset_password_state.dart';
import 'package:youtubefirebase/features/auth/screens/screen_login.dart';

class ResetPassword extends StatelessWidget {
  ResetPassword({super.key});
  final emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: Scaffold(
        backgroundColor: AppColors.grey,
        body: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccess) {
              showCustomSnackBar(
                context: context,
                message: 'Reset email sent',
                color: Colors.green,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            } else if (state is ResetPasswordFailure) {
              showCustomSnackBar(
                context: context,
                message: state.errorMessage,
                color: Colors.red,
              );
            }
          },
          builder: (context, state) {
            return Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 30,
                ),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 200),
                        Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColors.teal,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Enter your email to receive a reset link',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          maxLines: 2,
                          textAlign: TextAlign.start,
                        ),

                        const SizedBox(height: 60),

                        CustomTextFormField(
                          lable: 'Email',
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 30),

                        CustomBtn(
                          text: state is ResetPasswordLoading
                              ? 'Loading...'
                              : 'Reset Password',
                          onPressed: state is ResetPasswordLoading
                              ? null
                              : () {
                                  if (formkey.currentState!.validate()) {
                                    context
                                        .read<ResetPasswordCubit>()
                                        .resetpassword(
                                          emailController.text.trim(),
                                        );
                                  }
                                },
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
