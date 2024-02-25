import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

import '../../../../components/download_image.dart';
import '../../../customer/widgets/tost.dart';

// ignore: must_be_immutable
class ImageViewMessageUser extends StatelessWidget {
  ImageViewMessageUser({super.key, required this.imageMessage});
  String imageMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () async {
                  showToast(text: "جار حفظ الصوره.. ", State: ToastState.WARNING);
                  await downloadImage(imageMessage);
                },
                icon: const Icon(
                  Icons.download,
                  size: 30,
                )),
          )
        ],
      ),
      body: PhotoView(
        imageProvider: NetworkImage(imageMessage),
        initialScale: PhotoViewComputedScale.contained,
      ),
    );
  }
}
