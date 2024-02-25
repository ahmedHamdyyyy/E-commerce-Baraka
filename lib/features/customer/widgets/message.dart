
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop/config/colors/colors.dart';
import 'package:shop/core/services/service_locator.dart';
import 'package:shop/features/customer/logic/customer_cubit.dart';
import 'package:shop/features/customer/widgets/tost.dart';
import 'package:shop/features/user/logic/user_cubit.dart';

import '../../../models/message_model.dart';
import '../../user/screens/chat/show_image_message.dart';
import '../screens/home/chat/image_veiw_message.dart';

Widget customMessageFormCustomerAsCustomer(MessageModel model,CustomerState state,BuildContext context) {
  return   Align(
    alignment: Alignment.centerLeft,
    child: model.image!=""? GestureDetector(
      onTap: () {
        Navigator.
        push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ImageViewMessageUser(imageMessage: model.image.toString(),),
            ));
      },
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: ClipRRect(
                borderRadius:
                const BorderRadius.all(Radius.circular(10)),
                child:FadeInImage.assetNetwork(
                  image:   model.image.toString(),
                  placeholder: 'assets/images/loading.gif',
                )),
          ),
          if (model.text!="")
            Text(
              model.text.toString(),
              style:  TextStyle(
                color: kTextColor[state.theme],
              ),)
        ],
      ),
    ):Container(
      // alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Color(0xff2B515E),
      ),
      child: Column(
        children: [
          if (model.image!="")
            Padding(
                padding: const EdgeInsetsDirectional.only(),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>ImageViewMessageScreen (imageMessage:model.image!),
                        ));
                  },
                  child: SizedBox(
                    height: 250,
                    width: 250,
                   child: ClipRRect(
                       borderRadius:
                       const BorderRadius.all(Radius.circular(10)),
                       child:FadeInImage.assetNetwork(
                         image:   model.image.toString(),
                         placeholder: 'assets/images/loading.gif',
                       )),
                  ),
                ),
              ),
          if (model.text!="")
          Text(
            model.text.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget customMessageFormUserAsCustomer(MessageModel model,CustomerState state,BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child:model.image!=""? GestureDetector(
      onTap: () {
        Navigator.
        push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ImageViewMessageUser(imageMessage: model.image.toString(),),
            ));
      },
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: ClipRRect(
                borderRadius:
                const BorderRadius.all(Radius.circular(10)),
                child:FadeInImage.assetNetwork(
                  image:   model.image.toString(),
                  placeholder: 'assets/images/loading.gif',
                )),
          ),
          if (model.text!="")
            Text(
              model.text.toString(),
              style:  TextStyle(
                color: kTextColor[state.theme],
              ),)
        ],
      ),
    ): Container(
      //alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(0),
        ),
        color: Colors.deepOrange,
      ),
      child: Column(
        children: [
          if (model.image!="")
            Padding(
              padding: const EdgeInsetsDirectional.only(),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageViewMessageScreen( imageMessage: model.image!,),
                      ));
                },
                child: SizedBox(
                  height: 250,
                  width: 250,
                  child: ClipRRect(
                      borderRadius:
                      const BorderRadius.all(Radius.circular(10)),
                      child:FadeInImage.assetNetwork(
                        image:   'assets/images/loading.gif',
                        placeholder: 'assets/images/loading.gif',
                      )),
                ),
              ),
            ),
          if (model.text!="")
          Text(
            model.text.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget customMessageFormUserAsUser(MessageModel model,UserState state,BuildContext context) {
  return Align(
    alignment: Alignment.centerLeft,
    child:model.image!=""? GestureDetector(
      onTap: () {
        Navigator.
        push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ImageViewMessageUser(imageMessage: model.image.toString(),),
            ));
      },
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: ClipRRect(
                borderRadius:
                const BorderRadius.all(Radius.circular(10)),
                child:FadeInImage.assetNetwork(
                  image:   model.image.toString(),
                  placeholder: 'assets/images/loading.gif',
                )),
          ),
        if (model.text!="")
    Text(
      model.text.toString(),
      style:  TextStyle(
        color: kTextColor[0],
      ),)
        ],
      ),
    ): Container(
      // alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        color: Color(0xff2B515E),
      ),
      child: Column(
        children: [
          if (model.image!="")
            GestureDetector(
              onTap: () {
                Navigator.
                push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ImageViewMessageUser(
                            imageMessage: model.image.toString(),


                          ),
                    ));
              },
              child: Container(
                height: 250,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      model.image.toString(),
                    ),
                  ),
                ),
              ),
            ),
          if (model.text!="")
            Text(
              model.text.toString(),
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
        ],
      ),
    ),
  );
}

Widget customMessageFormMeCustomerAsUser(MessageModel model,UserState state,BuildContext context) {
  return Align(
    alignment: Alignment.centerRight,
    child:model.image!=""? GestureDetector(
      onTap: () {
        Navigator.
        push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ImageViewMessageUser(imageMessage: model.image.toString(),),
            ));
      },
      child: Column(
        children: [
          SizedBox(
            height: 200,
            width: 200,
            child: ClipRRect(
                borderRadius:
                const BorderRadius.all(Radius.circular(10)),
                child:FadeInImage.assetNetwork(
                  image:   model.image.toString(),
                  placeholder: 'assets/images/loading.gif',
                )),
          ),
          if (model.text!="")
            Text(
              model.text.toString(),
              style:  TextStyle(
                color: kTextColor[0],
              ),)
        ],
      ),
    ): Container(
      //alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10, right: 16),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(0),
        ),
        color: Colors.deepOrange,
      ),
      child: Column(
        children: [
          if (model.image!="")
          //if (state.imagePath!="")
            Padding(
              padding: const EdgeInsetsDirectional.only(),
              child: GestureDetector(
                onTap: () {
                  Navigator.
                  push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ImageViewMessageUser(
                              imageMessage: model.image.toString(),
                            ),
                      ));
                },
                child: Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        model.image.toString(),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (model.text!="")
          Text(
            model.text.toString(),
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );
}

Padding customerSendMessage({
  required TextEditingController controller,
  required CustomerState state,
  required String uIdUser,
  required BuildContext context,
  required ScrollController controllerScroll,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: TextFormField(

              onFieldSubmitted: (value) {
                DateTime now = DateTime.now();
                getit<CustomerCubit>().sendMessage(
                  dataTime:now.toString() ,
                  imagePost:  state.imagePath != "" ? state.imagePath : "" ,


                  receiverId: uIdUser,
                  text: value,

                );
                controllerScroll.animateTo(
                  0,
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeIn,
                );
                controller.clear();
                state.imagePath=="";
              },
              style:  TextStyle(color: kTextColor[state.theme]),
              controller: controller,
              decoration:  InputDecoration(
                suffixIcon: IconButton(
                  icon: const Icon(Icons.photo),
                  onPressed: (){
                  getit<CustomerCubit>().pickImageMessage(source: ImageSource.gallery);

                }

                ),
                //border: InputBorder.none,
                hintText: 'write your message here...',
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: MaterialButton(
            color: Colors.blueGrey,
            minWidth: 1.0,
            onPressed: () {

              DateTime now = DateTime.now();
              getit<CustomerCubit>().sendMessage(
                dataTime:now.toString() ,
                receiverId: uIdUser,
                text: controller.text,
                imagePost:  state.imagePath != "" ? state.imagePath : "" ,

              );

              controllerScroll.animateTo(
                0,
                duration: const Duration(milliseconds: 900),
                curve: Curves.bounceInOut,
              );

              controller.clear();
              state.imagePath=="";

              if(state.imagePath!=""){
                return showToast(text: " جار تحميل الصوره برجاء الانتظار", State: ToastState.SUCCESS);
              }
            },
            child: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget userSendMessage({
  required TextEditingController controller,
  required UserState state,
  required String uIdUser,
  required BuildContext context,
  required ScrollController controllerScroll,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: TextFormField(

              onFieldSubmitted: (value) {
                DateTime now = DateTime.now();
                getit<UserCubit>().sendMessage(
                  imageMessage:
                  state.imagePath != "" ? state.imagePath : "" ,
                  dataTime:now.toString() ,
                  receiverId: uIdUser,
                  text: value,

                );
                controllerScroll.animateTo(
                  0,
                  duration: const Duration(milliseconds: 900),
                  curve: Curves.easeIn,
                );
                controller.clear();
                state.imagePath=="";
              },
              style:  TextStyle(color: kTextColor[0]),
              controller: controller,


              decoration:  InputDecoration(
                suffixIcon: IconButton(
                    onPressed: ()
                {
                getit<UserCubit>().pickImageMessage(source: ImageSource.gallery);

                },
                    icon: const Icon(Icons.photo,size: 30,)),
                //border: InputBorder.none,
                hintText: 'write your message.',
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
          child: MaterialButton(
            color: Colors.blueGrey,
            minWidth: 1.0,
            onPressed: () {
              DateTime now = DateTime.now();
              getit<UserCubit>().sendMessage(
                dataTime:now.toString() ,
                receiverId: uIdUser,
               imageMessage:  state.imagePath != "" ? state.imagePath : "" ,
                text: controller.text,

              );

              controllerScroll.animateTo(
                0,
                duration: const Duration(milliseconds: 900),
                curve: Curves.bounceInOut,
              );
              controller.clear();
              state.imagePath=="";
            },
            child: const Icon(
              Icons.send,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}