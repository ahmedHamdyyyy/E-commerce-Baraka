import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../config/colors/colors.dart';
import '../../../core/services/service_locator.dart';
import '../../../models/message_model.dart';
import '../../customer/screens/home/chat/chat_with_user.dart';
import '../../customer/widgets/tost.dart';
import '../logic/user_cubit.dart';
import '../screens/chat/chat_with_customers.dart';
import 'build_snapshots_stream_message.dart';

class BuildListViewSearchCustomer extends StatelessWidget {
   BuildListViewSearchCustomer({super.key,required this.state});
  UserState state;
  @override
  Widget build(BuildContext context) {
    return
       ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreenCustomer(
                      customerId: state.customers[index].id),
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: nameColor(
                      state.customers[index].name[0]),
                  child: Text(
                    style: const TextStyle(
                        fontSize: 40, color: Colors.white),
                    state.customers[index].name[0],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.customers[index].name,
                        style: TextStyle(
                          color: kTextColor[0],
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      StreamBuilder<QuerySnapshot>(
                          stream:
                          buildSnapshotsStreamMessageAsUser(
                              getit<UserCubit>()
                                  .getId(),
                              state
                                  .customers[index].id),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<MessageModel> messages =
                              snapshot.data!.docs
                                  .map((doc) {
                                return MessageModel.fromMap(
                                    doc.data() as Map<
                                        String, dynamic>);
                              }).toList();
                              if (messages.isNotEmpty) {
                                return Text(
                                  messages.first.text
                                      .toString(),
                                  style: TextStyle(
                                    color: kTextColor[0],
                                    fontWeight:
                                    FontWeight.w900,
                                  ),
                                  overflow:
                                  TextOverflow.ellipsis,
                                  maxLines: 1,
                                );
                              } else {
                                return Text(
                                  'No messages',
                                  style: TextStyle(
                                    color: kTextColor[0],
                                    fontWeight:
                                    FontWeight.w900,
                                  ),
                                );
                              }
                            }

                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              // Handle the loading state
                              return buildCenterLod();
                            }
                            return Text(
                                'Error: ${snapshot.error}');
                          }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        separatorBuilder: (context, index) => Padding(
          padding:
          const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            height: 1,
            color: Colors.grey[300],
          ),
        ),
        itemCount: state.customers.length,
      );
    }
  }

