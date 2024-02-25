import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/config/constants/constance.dart';
import 'package:shop/core/services/service_locator.dart';

import '../../../../../models/message_model.dart';
import '../../../logic/customer_cubit.dart';
import '../../../widgets/appbar_chats.dart';
import '../../../widgets/message.dart';

class ChatScreenUser extends StatefulWidget {
  const ChatScreenUser({super.key, required this.uIdUser});
  final String uIdUser;
  @override
  State<ChatScreenUser> createState() => _ChatScreenUserState();
}

class _ChatScreenUserState extends State<ChatScreenUser> {
  TextEditingController controller = TextEditingController();
  final _controllerScroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    final customerId = getit<CustomerCubit>().getId();
    return BlocProvider.value(
      value: getit<CustomerCubit>()..getUser(widget.uIdUser),
      child: BlocConsumer<CustomerCubit, CustomerState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: appBarChat(state),
              body: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: buildSnapshotsStreamMessage(customerId,widget.uIdUser),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<MessageModel> messages =
                                snapshot.data!.docs.map((doc) {
                              return MessageModel.fromMap(
                                  doc.data() as Map<String, dynamic>);
                            }).toList();

                            // Process the retrieved messages
                            return ListView.builder(
                              reverse: true,
                              controller: _controllerScroll,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                // Display the message in your UI
                                return message.senderId == customerId
                                    ? customMessageFormCustomerAsCustomer(
                                        message, state, context)
                                    : customMessageFormUserAsCustomer(
                                        message, state, context);
                              },
                            );
                            // Handle the error state
                            // return
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            // Handle the loading state
                            return buildCenterLod();
                          }
                          return Text('Error: ${snapshot.error}');
                        },
                      ),
                    ),
                    customerSendMessage(
                        controllerScroll: _controllerScroll,
                        state: state,
                        context: context,
                        controller: controller,
                        uIdUser: widget.uIdUser),
                  ],
                ),
              ),
            );
          }),
    );
  }


}  Center buildCenterLod() {
  return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
        ],
      ));
}
Stream<QuerySnapshot<Map<String, dynamic>>> buildSnapshotsStreamMessage(String customerId,String userId) {
  return FirebaseFirestore.instance
      .collection(AppConst.customerCollection)
      .doc(customerId)
      .collection(AppConst.chats)
      .doc(userId)
      .collection(AppConst.messages)
      .orderBy('dataTime', descending: true)
      .snapshots();}