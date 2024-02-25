// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/config/constants/constance.dart';
import 'package:shop/features/user/widgets/Loding.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../models/message_model.dart';
import '../../../logic/customer_cubit.dart';
import '../../../widgets/tost.dart';
import 'chat_with_user.dart';

class AllUserScreenChats extends StatelessWidget {
  const AllUserScreenChats({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<CustomerCubit>()..getAllUsers(),
      child: BlocBuilder<CustomerCubit, CustomerState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: const Text(
              "Chats Your Friends",
            ),
          ),
          body: state.getAllUsersState == Status.loading
              ? loading()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreenUser(
                                  uIdUser: state.users[index].id),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor:
                                  nameColor(state.users[index].shopName[0]),
                              child: Text(
                                style: const TextStyle(
                                    fontSize: 40, color: Colors.white),
                                state.users[index].shopName[0],
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
                                    state.users[index].shopName,
                                    style: TextStyle(
                                      color: kTextColor[state.theme],
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                      stream: buildSnapshotsStreamMessage(
                                          getit<CustomerCubit>().getId(),
                                          state.users[index].id),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          List<MessageModel> messages =
                                              snapshot.data!.docs.map((doc) {
                                            return MessageModel.fromMap(doc
                                                .data() as Map<String, dynamic>);
                                          }).toList();
                                          if (messages.isNotEmpty) {
                                            return Text(

                                              messages.first.text.toString(),
                                              style: TextStyle(
                                                color: kTextColor[state.theme],
                                                fontWeight: FontWeight.w900,
                                              ),
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                            );
                                          } else {
                                            return Text(
                                              'No messages',
                                              style: TextStyle(
                                                color: kTextColor[state.theme],
                                                fontWeight: FontWeight.w900,
                                              ),
                                            );
                                          }
                                        }

                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          // Handle the loading state
                                          return buildCenterLod();
                                        }
                                        return Text('Error: ${snapshot.error}');
                                      }),
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
                    itemCount: state.users.length,
                  ),
                ),
        ),
      ),
    );
  }
}
