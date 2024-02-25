  import 'package:flutter/material.dart';

import '../../../../config/colors/colors.dart';

import 'components/sign_form.dart';

class SignInScreenUser extends StatefulWidget {
  const SignInScreenUser({super.key});

  @override
  State<SignInScreenUser> createState() => _SignInScreenUserState();
}

class _SignInScreenUserState extends State<SignInScreenUser> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(height: 70),
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
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
