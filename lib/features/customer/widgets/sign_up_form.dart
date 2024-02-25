// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../config/colors/colors.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/validation/input_validation.dart';
import '../../../models/address.dart';
import '../../../models/customer.dart';
import '../logic/customer_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final name = TextEditingController();
  bool remember = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<CustomerCubit>(),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: name,
              style: TextStyle(
                color: kTextColor[0],
                height: 1.5,
              ),
              keyboardType: TextInputType.name,
              validator: (value) => InputValidation.nameValidation(value),
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Enter your Name",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: TextStyle(
                color: kTextColor[0],
                height: 1.5,
              ),
              controller: email,
              keyboardType: TextInputType.emailAddress,
              validator: (value) => InputValidation.emailValidation(value),
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Enter your email",
                //floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: TextStyle(
                color: kTextColor[0],
                height: 1.5,
              ),
              controller: password,
              obscureText: true,
              validator: (value) => InputValidation.passwordValidation(value),
              decoration: const InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              style: TextStyle(
                color: kTextColor[0],
                height: 1.5,
              ),
              controller: phone,
              obscureText: true,
              keyboardType: TextInputType.number,
              validator: (value) => InputValidation.phoneValidation(value),
              decoration: const InputDecoration(
                labelText: "phone",
                hintText: "Enter your phone",
                floatingLabelBehavior: FloatingLabelBehavior.always,
                suffixIcon: CustomSuffixIcon(svgIcon: "assets/icons/Phone.svg"),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
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
                getit<CustomerCubit>().signUp(
                    CustomerModel(
                        id: "",
                        userCart:const [],
                        name: name.text.trim(),
                        email: email.text.trim(),
                        phone: phone.text.trim(),
                        address: AddressModel.non,
                        favorite: const []),
                    password.text.trim());
              },
              child: Text(
                "Sign up",
                style:
                    TextStyle(color: kTextColor[1], height: 1.5, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
