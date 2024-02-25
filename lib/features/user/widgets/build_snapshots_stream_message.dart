import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../config/constants/constance.dart';

Stream<QuerySnapshot<Map<String, dynamic>>> buildSnapshotsStreamMessageAsUser ( String userId,String customerId)=>
   FirebaseFirestore.instance
      .collection(AppConst.userCollection)
      .doc(userId)
      .collection(AppConst.chats)
      .doc(customerId)
      .collection(AppConst.messages)
      .orderBy('dataTime', descending: true)
      .snapshots();


