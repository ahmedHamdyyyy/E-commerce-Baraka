import 'package:flutter/material.dart';

import '../../../config/colors/colors.dart';
import '../../../config/widgets/cart_screen_empty.dart';
import '../../customer/widgets/tost.dart';
import '../logic/user_cubit.dart';
import '../screens/chat/chat_with_customers.dart';

class BuildListViewCustomerAll extends StatelessWidget {
   BuildListViewCustomerAll({super.key,required this.state});
  UserState state;
  @override
  Widget build(BuildContext context) {

    return state.searchCustomers.isEmpty?  ScreenImpty(imagePath: "assets/images/no_user_found.png", text: "The Customer is not Found"): ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) =>  InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChatScreenCustomer(
                    customerId: state.searchCustomers[index].id),
              ));
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor:
                nameColor(state.searchCustomers[index].name[0]),
                child: Text(
                  style: const TextStyle(
                      fontSize: 40, color: Colors.white),
                  state.searchCustomers[index].name[0],
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.searchCustomers[index].name,
                      style: TextStyle(
                        color: kTextColor[0],
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Container(
          height: 1,
          color: Colors.grey[300],
        ),
      ),
      itemCount: state.searchCustomers.length,
    );

  }
}
