import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/features/customer/logic/customer_cubit.dart';

import '../../../config/colors/colors.dart';
import '../../../core/services/service_locator.dart';
import '../logic/cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
            value: getit<HomeCubit>()..setApp(context),
          ),
          BlocProvider.value(
            value: getit<CustomerCubit>()..getTheme(),
          ),
        ],
        child: BlocBuilder<CustomerCubit, CustomerState>(
          builder: (context, state) {
            return Scaffold(
              backgroundColor: primaryColor[state.theme],
              appBar: AppBar(
                backgroundColor: primaryColor[state.theme],
              ),
              // title: Text(S.of(context).book,style: TextStyle(color:  kTextColor[state.theme],),)),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                      child: CircularProgressIndicator(
                    color: kTextColor[state.theme],
                    backgroundColor: kTextColor[state.theme],
                  )),
                ],
              ),
            );
          },
        ),
      );
}
