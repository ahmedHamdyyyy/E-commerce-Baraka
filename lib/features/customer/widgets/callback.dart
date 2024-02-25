import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/constants/constance.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/utils.dart';
import '../logic/customer_cubit.dart';

class CustomerSignCallback extends StatelessWidget {
  const CustomerSignCallback({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: getit<CustomerCubit>(),
        child: BlocListener<CustomerCubit, CustomerState>(
          listenWhen: (previous, current) =>
              previous.signInState != current.signInState,
          listener: (context, state) {
            switch (state.signInState) {
              case Status.loading:
                Utils.loadingDialog(context);
                break;
              case Status.success:
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, AppConst.customerScreen, (route) => false);
                break;
              case Status.error:
                Navigator.pop(context);
                Utils.errorDialog(context, state.msg);
                break;
              case Status.initial:
                break;
            }
          },
          child: const SizedBox.shrink(),
        ),
      );
}

class CustomerSignUpCallback extends StatelessWidget {
  const CustomerSignUpCallback({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: getit<CustomerCubit>(),
        child: BlocListener<CustomerCubit, CustomerState>(
          listenWhen: (previous, current) =>
              previous.signUpState != current.signUpState,
          listener: (context, state) {
            switch (state.signUpState) {
              case Status.loading:
                Utils.loadingDialog(context);
                break;
              case Status.success:
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, AppConst.customerScreen, (route) => false);
                break;
              case Status.error:
                Navigator.pop(context);
                Utils.errorDialog(context, state.msg);
                break;
              case Status.initial:
                break;
            }
          },
          child: const SizedBox.shrink(),
        ),
      );
}
