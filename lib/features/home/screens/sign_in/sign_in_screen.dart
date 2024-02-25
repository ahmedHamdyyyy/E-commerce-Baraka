// ignore_for_file: deprecated_member_use

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/features/customer/widgets/tost.dart';

import '../../../../components/no_account_text.dart';
import '../../../../components/socal_card.dart';
import '../../../../config/colors/colors.dart';
import '../../../../core/services/service_locator.dart';
import '../../../customer/logic/customer_cubit.dart';
import '../../logic/cubit.dart';
import 'components/sign_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Sign In"),
        ),
        body: BlocProvider.value(
          value: getit<HomeCubit>(),
          child: SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          "Welcome Back",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: kTextColor[0],
                            height: 1.5,
                          ),
                        ),
                        Text(
                          "Sign in with your email and password  \nor continue with social media",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: kTextColor[0],
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const SignForm(),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SocialCard(
                              icon: "assets/icons/facebook-2.svg",
                              press: () async {
                                showToast(
                                    text: "باذن الله هعملها بعدين",
                                    State: ToastState.ERROR);
                              },
                            ),
                            BlocProvider.value(
                              value: getit<CustomerCubit>(),
                              child: SocialCard(
                                icon: "assets/icons/google-icon.svg",
                                press: () {
                                  showToast(
                                      text: "باذن الله هعملها بعدين",
                                      State: ToastState.ERROR);
                                },
                              ),
                            ),
                            SocialCard(
                              icon: "assets/icons/twitter.svg",
                              press: () {
                                showToast(
                                    text: "باذن الله هعملها بعدين",
                                    State: ToastState.ERROR);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const NoAccountText(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
