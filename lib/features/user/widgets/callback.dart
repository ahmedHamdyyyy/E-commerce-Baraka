import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/core/utils/utils.dart';

import '../../../config/constants/constance.dart';
import '../../../core/services/service_locator.dart';
import '../logic/user_cubit.dart';

class UserSignCallback extends StatelessWidget {
  const UserSignCallback({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: getit<UserCubit>(),
        child: BlocListener<UserCubit, UserState>(
          listenWhen: (previous, current) =>
              previous.signInState != current.signInState,
          listener: (context, state) {
            //print(state.signInState);
            switch (state.signInState) {
              case Status.loading:
                Utils.loadingDialog(context);
                break;
              case Status.success:
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, AppConst.userScreen, (route) => false);
                break;
              case Status.error:
                Navigator.pop(context);
                return Utils.errorDialog(context, state.msg);
              case Status.initial:
                break;
            }
          },
          child: const SizedBox.shrink(),
        ),
      );
}

class UserSignCallbackInfo extends StatelessWidget {
  const UserSignCallbackInfo({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: getit<UserCubit>(),
        child: BlocListener<UserCubit, UserState>(
          listenWhen: (previous, current) =>
              previous.signInState != current.signInState,
          listener: (context, state) {
            //print(state.signInState);
            switch (state.signInState) {
              case Status.loading:
                //Utils.loadingDialog(context);
                break;
              case Status.success:
                //Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(
                    context, AppConst.userScreen, (route) => false);
                break;
              case Status.error:
                //Navigator.pop(context);
                Utils.errorDialog(context, state.msg);
                Navigator.pop(context);
                break;
              case Status.initial:
                break;
            }
          },
          child: const SizedBox.shrink(),
        ),
      );
}
