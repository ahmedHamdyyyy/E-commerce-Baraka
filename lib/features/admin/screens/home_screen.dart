import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/user.dart';

import '../../../core/services/service_locator.dart';
import '../../../models/address.dart';
import '../logic/cubit.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => getit<AdminCubit>(),
        child: BlocBuilder<AdminCubit, AdminState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(state.admin.id),
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        onPressed: () {
                          getit<AdminCubit>().addUser(
                              const UserModel(
                                  address: AddressModel(
                                      city: "صن الحجر", location: []),
                                  id: "",
                                  date: "6-10-2000",
                                  shopName: "محل كتب",
                                  mail: "hakim@gmail.com",
                                  phone: "01150  644125"),
                              "12345678");
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.redAccent,
                          size: 60,
                        ))
                  ],
                ),
              ),
            );
          },
        ),
      );
}
