import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/features/customer/widgets/tost.dart';
import 'package:shop/features/user/logic/user_cubit.dart';
import 'package:shop/features/user/widgets/build_snapshots_stream_message.dart';

import '../../../../config/constants/constance.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../models/message_model.dart';
import '../../../customer/widgets/appbar_chats.dart';
import '../../../customer/widgets/message.dart';

// ignore: must_be_immutable
class ChatScreenCustomer extends StatefulWidget {
  const ChatScreenCustomer({super.key, required this.customerId});
  final String customerId;
  @override
  State<ChatScreenCustomer> createState() => _ChatScreenCustomerState();
}
class _ChatScreenCustomerState extends State<ChatScreenCustomer> {
  TextEditingController controller = TextEditingController();
  final _controllerScroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    final userId = getit<UserCubit>().getId();
    return BlocProvider.value(
      value: getit<UserCubit>()..customer(widget.customerId)..getImage(),
      child: BlocBuilder<UserCubit, UserState>(

          builder: (context, state) {
            return Scaffold(
              appBar: appBarChatUser(state),
              body: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: [
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                        stream: buildSnapshotsStreamMessageAsUser(userId,widget.customerId),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            List<MessageModel> messages =
                            snapshot.data!.docs.map((doc) {
                              return MessageModel.fromMap(doc.data() as Map<String,dynamic>);
                            }).toList();

                            return ListView.builder(
                              reverse: true,
                              controller: _controllerScroll,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                return message.senderId == userId
                                    ? customMessageFormUserAsUser(message,state,context)
                                    : customMessageFormMeCustomerAsUser(message,state,context);
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
                    userSendMessage(
                        controllerScroll: _controllerScroll,
                        state: state,
                        context: context,
                        controller: controller,
                        uIdUser: widget.customerId),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Center buildCenterLod() {
    return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
          ],
        ));
  }


}
