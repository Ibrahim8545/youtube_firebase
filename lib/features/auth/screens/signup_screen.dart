import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtubefirebase/core/custom_button.dart';
import 'package:youtubefirebase/core/custom_password_field.dart';
import 'package:youtubefirebase/core/custom_snack_bar.dart';
import 'package:youtubefirebase/core/custom_textformfield.dart';
import 'package:youtubefirebase/core/utils/colors.dart';
import 'package:youtubefirebase/features/auth/manager/signup_cubit/signup_cubit.dart';
import 'package:youtubefirebase/features/auth/manager/signup_cubit/signup_state.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupLoading) {
            // Show loading indicator
            showCustomSnackBar(
              context: context,
              message: 'Signing up...',
              color: Colors.blue,
            );
          } else if (state is SignupSuccess) {
            // Navigate to home screen or show success message

            showCustomSnackBar(
              context: context,
              message: 'Signup Success',
              color: Colors.green,
            );
            Navigator.pop(context);
          } else if (state is SignupFailure) {
            // Show error message
            showCustomSnackBar(
              context: context,
              message: state.errorMessage,
              color: Colors.red,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.grey,
            body: Form(
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
                        const SizedBox(height: 120),
                        const Text(
                          'Signup',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColors.teal,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          lable: 'Name',
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },

                          textInputType: TextInputType.name,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          lable: 'Phone Number',
                          controller: phoneController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
                            }
                            return null;
                          },
                          textInputType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          lable: 'Email',
                          controller: emailController,
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 12),
                        PasswordField(
                          lable: 'Password',
                          controller: passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        PasswordField(
                          lable: 'Confirm Password',
                          controller: confirmPasswordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != passwordController.text) {
                              return 'Passwords do not match';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 24),

                        CustomBtn(
                          text: 'Sign Up',
                          onPressed: () {
                            if (formkey.currentState!.validate()) {
                              context.read<SignupCubit>().signup(
                                email: emailController.text.trim(),
                                password: passwordController.text,
                                name: nameController.text.trim(),
                                phone: phoneController.text.trim(),
                              );
                            }
                          },
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(" Already have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
