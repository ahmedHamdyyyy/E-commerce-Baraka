import 'package:flutter/material.dart';

import '../../../../../components/custom_surfix_icon.dart';
import '../../../../../config/colors/colors.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/validation/input_validation.dart';
import '../../../../admin/logic/cubit.dart';
import '../../../../admin/widgets/callback.dart';
import '../../../../home/screens/forgot_password/forgot_password_screen.dart';
import '../../../../user/logic/user_cubit.dart';
import '../../../widgets/callback.dart';

class SignForm extends StatefulWidget {
  const SignForm({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  bool? remember = false;
  bool _isUser = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          const UserSignCallbackInfo(),
          const AdminSignCallback(),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: email,
            style: TextStyle(color: kTextColor[0]),
            validator: (value) => InputValidation.emailValidation(value),
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: password,
            obscureText: true,
            style: TextStyle(color: kTextColor[0]),
            validator: (value) => InputValidation.passwordValidation(value),
            decoration: const InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: checkOutCartColor[0],
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              // const Text("Remember me"),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ),
                  );
                },
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kTextColor[0]),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          StatefulBuilder(
            builder: (context, setState) => CheckboxListTile(
              value: _isUser,
              title: const Text('User'),
              onChanged: (value) => setState(() {
                _isUser = value ?? true;
              }),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              backgroundColor: checkOutCartColor[0],
              foregroundColor: primaryColor[0],
              minimumSize: const Size(double.infinity, 48),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;
              _isUser
                  ? getit<UserCubit>().signIn(
                      email.text.trim(),
                      password.text.trim(),
                    )
                  : getit<AdminCubit>()
                      .signIn(email.text.trim(), password.text.trim());
            },
            child: Text(
              'Sing In',
              style: TextStyle(color: kTextColor[1], fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 18,
          ),
        ],
      ),
    );
  }
}
