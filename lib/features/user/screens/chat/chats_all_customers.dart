import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/config/constants/constance.dart';
import 'package:shop/config/services/assets_manager.dart';
import 'package:shop/config/widgets/cart_screen_empty.dart';
import 'package:shop/features/customer/widgets/tost.dart';
import 'package:shop/features/user/screens/chat/chat_with_customers.dart';
import 'package:shop/features/user/widgets/build_list_view_all_customers.dart';
import 'package:shop/features/user/widgets/build_snapshots_stream_message.dart';
import 'package:shop/features/user/widgets/Loding.dart';
import '../../../../config/colors/colors.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../models/message_model.dart';
import '../../../customer/logic/customer_cubit.dart';
import '../../../customer/screens/home/chat/chat_with_user.dart';
import '../../../home/screens/forgot_password/search_outline_input_border.dart';
import '../../logic/user_cubit.dart';
import '../../widgets/build_list_view_search_ustomer.dart';

class AllCustomersChatScreen extends StatelessWidget {
  const AllCustomersChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final control = TextEditingController();
    return BlocProvider.value(
      value: getit<UserCubit>()..getCustomers(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            titleSpacing: 0,
            title: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: TextFormField(
                style: TextStyle(color: kTextColor[0]),
                controller: control,
                onChanged: (value) {
                  getit<UserCubit>().searchCustomers(value);
                },
                decoration: InputDecoration(
                  filled: true,
                  fillColor: kTextColor[0].withOpacity(0.1),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  border: searchOutlineInputBorder,
                  focusedBorder: searchOutlineInputBorder,
                  enabledBorder: searchOutlineInputBorder,
                  hintText: "Search Customer",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: InkWell(
                      onTap: () {
                        getit<UserCubit>().deleteSearchUser();
                        control.clear();
                      },
                      child: const Icon(Icons.close)),
                ),
              ),
            ),
          ),
          body: switch (state.searchCostomerStatus) {
            Status.initial => BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: state.getAllCustomersStatus == Status.loading
                        ? Loading()
                        : BuildListViewSearchCustomer(state: state),
                  );
                },
              ),
            Status.loading => Loading(),
            Status.success => BuildListViewCustomerAll(state: state),
            Status.error => ScreenImpty(imagePath: AssetsManager.errorImage, text: "There was an Error"),
          },
        ),
      ),
    );
  }



}
