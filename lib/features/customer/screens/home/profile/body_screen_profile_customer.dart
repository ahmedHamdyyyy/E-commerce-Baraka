import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../config/constants/constance.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/utils.dart';
import '../../../logic/customer_cubit.dart';
import '../../../widgets/profile_menu.dart';
import '../../../widgets/profile_pic.dart';

class BodyScreenPprofileCustomer extends StatelessWidget {
  const BodyScreenPprofileCustomer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: BlocBuilder<CustomerCubit, CustomerState>(
        builder: (context, state) {
          return Column(
            children: [
              ProfilePic(
                colorIcon: kTextColor[state.theme],
                color: foreGroundColor[state.theme],
              ),
              const SizedBox(height: 20),
              ProfileMenu(
                  colorText: kTextColor[state.theme],
                  color: primaryColor[state.theme],
                  text: state.customer.name,
                  icon: "assets/icons/User Icon.svg",
                  press: () {}),
              ProfileMenu(
                  colorText: kTextColor[state.theme],
                  color: primaryColor[state.theme],
                  text: state.customer.email,
                  icon: "assets/icons/Mail.svg",
                  press: () {}),
              ProfileMenu(
                colorText: kTextColor[state.theme],
                color: primaryColor[state.theme],
                text: "Notifications",
                icon: "assets/icons/Bell.svg",
                press: () {},
              ),
              ProfileMenu(
                colorText: kTextColor[state.theme],
                color: primaryColor[state.theme],
                text: "Settings",
                icon: "assets/icons/Settings.svg",
                press: () {},
              ),
              ProfileMenu(
                colorText: kTextColor[state.theme],
                color: primaryColor[state.theme],
                text: "Help Center",
                icon: "assets/icons/Question mark.svg",
                press: () {},
              ),
              BlocListener<CustomerCubit, CustomerState>(
                listenWhen: (previous, current) =>
                previous.logOutState != current.logOutState,
                listener: (context, state) {
                  if (state.logOutState == Status.success) {
                    getit<CustomerCubit>().inatTheme();
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppConst.signInScreen, (route) => false);
                    Utils.successSnackBar(context, state.msg);
                  }
                },
                child: ProfileMenu(
                  colorText: kTextColor[state.theme],
                  color: primaryColor[state.theme],
                  text: "Log Out",
                  icon: "assets/icons/Log out.svg",
                  press: () {
                    getit<CustomerCubit>().logOut();
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}