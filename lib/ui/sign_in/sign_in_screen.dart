import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:real_time_maps/common_widget/extentions.dart';
import 'package:real_time_maps/ui/sign_in/bloc/sign_in_bloc.dart';
import 'package:real_time_maps/ui/sign_in/bloc/sign_in_event.dart';
import 'package:real_time_maps/ui/sign_in/bloc/sign_in_state.dart';
import '../../../common_widget/CustomTextField.dart';
import '../../../resources/image_resources.dart';
import '../../common_widget/custom_button.dart';
import '../../resources/color_resources.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final height = MediaQuery.sizeOf(context).height;
    double paddingHorizontal = width * 0.05;
    double paddingVertical = height * 0.02;
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return BlocProvider(
      create: (context) => SignInBloc(),
      child: BlocConsumer<SignInBloc, SignInState>(
        listener: (context, state) {
          if (state.status == Status.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Login successful!")),
            );
            context.go('/dashboard', extra: state.email,);
          } else if (state.status == Status.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorValidation ?? "Unknown error")),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: SafeArea(
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 8),
                          Image.asset(
                            height: height * 0.3,
                            logo,
                          ),
                          Text("Sign In", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)),
                          SizedBox(height: paddingVertical),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Email', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23)),
                                  ),
                                ),
                                CustomTextField(
                                  errorText: state.emailValidation,
                                  hint: "Demo123@gmail.com",
                                  controller: emailController,
                                  onChanged: (value) {
                                    context.read<SignInBloc>().add(EmailInputEvent(email: value));
                                  },
                                ),

                                SizedBox(height: paddingVertical),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text('Password', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23)),
                                  ),
                                ),
                                CustomTextField(
                                  errorText: state.passwordValidation,
                                  hint: "Demo123",
                                  controller: passwordController,
                                  onChanged: (value) {
                                    context.read<SignInBloc>().add(PasswordInputEvent(password: value));
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: paddingVertical),
                          Padding(
                            padding: EdgeInsets.all(paddingHorizontal),
                            child: CustomButton(
                              buttonText: 'Sign in',
                              onPressed: () {
                                context.read<SignInBloc>().add(SignInSubmittedEvent());
                              },
                              color1: buttonColor1,
                              color2: buttonColor2,
                            ),
                          ),
                          SizedBox(height: paddingVertical),
                        ],
                      ),
                    ),
                  ),
                ),
                if(state.status==Status.processing)
                Center(
                child: CircularProgressIndicator(
                  color: buttonColor1,
                  strokeWidth: 2,
                ),
              ),]

            ),
          );
        },
      ),
    );
  }
}

