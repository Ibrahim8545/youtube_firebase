import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtubefirebase/core/custom_button.dart';
import 'package:youtubefirebase/core/custom_password_field.dart';
import 'package:youtubefirebase/core/custom_snack_bar.dart';
import 'package:youtubefirebase/core/custom_textformfield.dart';
import 'package:youtubefirebase/core/utils/colors.dart';
import 'package:youtubefirebase/features/auth/manager/login_cubit/login_cubit.dart';
import 'package:youtubefirebase/features/auth/manager/login_cubit/login_state.dart';
import 'package:youtubefirebase/features/auth/screens/home_screen.dart';
import 'package:youtubefirebase/features/auth/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        backgroundColor: AppColors.grey,

        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginLoading) {
              // Show loading indicator
              showCustomSnackBar(
                context: context,
                message: 'Logging in...',
                color: Colors.blue,
              );
            } else if (state is LoginSuccess) {
              // Navigate to home screen or show success message
              showCustomSnackBar(
                context: context,
                message: 'Login Success',
                color: Colors.green,
              );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            } else if (state is LoginFailure) {
              // Show error message
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
                          'Login',
                          style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: AppColors.teal,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          lable: 'Email',
                          controller: emailController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          textInputType: TextInputType.emailAddress,
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
                        const SizedBox(height: 24),
                        state is LoginLoading
                            ? Center(child: CircularProgressIndicator())
                            : CustomBtn(
                                text: 'Login',
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    context.read<LoginCubit>().login(
                                      email: emailController.text.trim(),
                                      password: passwordController.text,
                                    );
                                  }
                                },
                              ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignupScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign Up',
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
            );
          },
        ),
      ),
    );
  }
}
