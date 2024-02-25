import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../logic/customer_cubit.dart';
import 'body_screen_profile_customer.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomerCubit, CustomerState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            actions: [
              IconButton(
                  onPressed: () {
                    getit<CustomerCubit>().setTheme(state.theme);
                  },
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                    size: 40,
                  ))
            ],
          ),
          body: BodyScreenPprofileCustomer(),
        );
      },
    );
  }
}


