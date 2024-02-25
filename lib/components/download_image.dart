
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

import '../features/customer/widgets/tost.dart';

Future<void> downloadImage(String imageMessage ) async {
  await Permission.storage.request();

  var response = await Dio().get(imageMessage,
      options: Options(responseType: ResponseType.bytes));
  final result = await ImageGallerySaver.saveImage(
      Uint8List.fromList(response.data),
      quality: 80,
      name: "hello");
  if(result["isSuccess"]==true){
    showToast(text: "تم حفظ الصوره بنجاح", State: ToastState.SUCCESS);
  }
}