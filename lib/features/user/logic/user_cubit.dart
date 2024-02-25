import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop/features/customer/widgets/tost.dart';
import '../../../config/constants/constance.dart';
import '../../../models/customer.dart';
import '../../../models/message_model.dart';
import '../../../models/product.dart';
import '../../../models/user.dart';
import '../data/repository.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this._repo) : super(const UserState());
  final UserRepository _repo;

  void signIn(String email, String password) async {
    try {
      emit(state.copyWith(signInState: Status.loading));
      final user = await _repo.signIn(email, password);
      emit(state.copyWith(
          user: user, msg: 'success process', signInState: Status.success));
    } on Exception catch (e) {
      emit(state.copyWith(signInState: Status.error, msg: e.toString()));
    }
  }

  String getId() => _repo.getId()!;

  void logOut() async {
    emit(state.copyWith(logOutState: Status.loading));
    try {
      await _repo.logOut();
      emit(state.copyWith(logOutState: Status.success, msg: "خرج بنجاح "));
    } on Exception catch (e) {
      emit(state.copyWith(logOutState: Status.error, msg: e.toString()));
    }
  }

  void getUser(String id) async {
    emit(state.copyWith(getDataUserState: Status.loading));
    try {
      final user = await _repo.getUser(id);
      emit(state.copyWith(getDataUserState: Status.success, user: user));
    } on Exception catch (e) {
      emit(state.copyWith(getDataUserState: Status.error, msg: e.toString()));
    }
  }

  void addProduct(ProductModel product) async {
    try {
      emit(state.copyWith(addProductStatus: Status.loading));
      final uploadedProduct = await _repo.addProduct(product);
      final userProducts = List<ProductModel>.from(state.userProducts)
        ..add(uploadedProduct);
      emit(state.copyWith(
        userProducts: userProducts,
        addProductStatus: Status.success,
        msg: 'add product success ',
      ));
      showToast(text: "Add product Successfully ❤️",  State: ToastState.SUCCESS);
    } catch (e) {
      emit(state.copyWith(addProductStatus: Status.error));
    }
  }

  void getProduct(String id) async {
    try {
      emit(state.copyWith(getProductStatus: Status.loading));
      final product = await _repo.getProduct(id);
      emit(state.copyWith(
        product: product,
        getProductStatus: Status.success,
        msg: 'get 1 success process',
      ));
    } on Exception catch (e) {
      emit(state.copyWith(getProductStatus: Status.error, msg: e.toString()));
    }
  }

  void updateProduct(ProductModel product) async {
    try {
      emit(state.copyWith(updateProductStatus: Status.loading));
      await _repo.updateProduct(product);
      final List<ProductModel> listProduct = List.from(state.productsUser);
      final index =
          state.productsUser.indexWhere((element) => element.id == product.id);
      listProduct[index] = product;
      emit(state.copyWith(
        userProducts: listProduct,
        updateProductStatus: Status.success,
        msg: 'success update',
      ));
      showToast(text:  "Update Product Successfully ❤️", State: ToastState.SUCCESS);
    } on Exception catch (e) {
      emit(
          state.copyWith(updateProductStatus: Status.error, msg: e.toString()));
    }
  }
  void search(String name) async {
    emit(state.copyWith(searchProductsState: Status.loading));

    try {
      final productsSearch = await _repo.search(name);
      emit(state.copyWith(
          searchProduct: productsSearch, searchProductsState: Status.success));
      if (name == "")
        emit(state
            .copyWith(searchProduct: [], searchProductsState: Status.initial));
    } catch (e) {
      emit(state.copyWith(searchProductsState: Status.error));
    }
  }
  void deleteSearchUser() {
    emit(
        state.copyWith(searchCustomers: [], searchCostomerStatus: Status.initial));
  }
  void deleteSearch() {
    emit(
        state.copyWith(searchProduct: [], searchProductsState: Status.initial));
  }
  void deleteProduct(ProductModel productModel) async {
    try {
      emit(state.copyWith(deleteProductStatus: Status.loading));
      await _repo.deleteProduct(productModel);
      final List<ProductModel> listProduct = List.from(state.productsUser);
      listProduct.removeWhere((element) => element == productModel);
      emit(state.copyWith(
        userProducts: listProduct,
        deleteProductStatus: Status.success,
        msg: 'success delete',
      ));
      getAllProductUser(getId());
    } on Exception catch (e) {
      emit(
          state.copyWith(deleteProductStatus: Status.error, msg: e.toString()));
    }
  }

  void updateProduct2(ProductModel product) async {
    try {
      emit(state.copyWith(updateProductStatus: Status.loading));
      await _repo.updateProduct(product);
      final index =
          state.productsUser.indexWhere((element) => element.id == product.id);
      emit(state.copyWith(
        userProducts: List<ProductModel>.from(state.productsUser)
          ..[index] = product,
        updateProductStatus: Status.success,
        msg: 'success update',
      ));
    } on Exception catch (e) {
      emit(
          state.copyWith(updateProductStatus: Status.error, msg: e.toString()));
    }
  }

  void getCustomers() async {
    emit(state.copyWith(getAllCustomersStatus: Status.loading));

    try {
      final customers = await _repo.getCustomers();
      emit(state.copyWith(
          customers: customers, getAllCustomersStatus: Status.success));
    } catch (e) {
      emit(state.copyWith(getAllCustomersStatus: Status.error));
    }
  }

  void searchCustomers(String name) async {
    emit(state.copyWith(searchCostomerStatus: Status.loading));
    try {
      final customers = await _repo.searchCustomers(name);
      emit(state.copyWith(
          searchCustomers: customers, searchCostomerStatus: Status.success));
    if(name==""){
      emit(state.copyWith(searchCustomers: [],searchCostomerStatus: Status.initial));
    }

    } catch (e) {
      emit(state.copyWith(searchCostomerStatus: Status.error));
    }
  }

  void customer(String id) async {
    try {
      emit(state.copyWith(getCustomerStatus: Status.loading));
      final customer = await _repo.customer(id);
      emit(state.copyWith(
          getCustomerStatus: Status.success, customer: customer));
    } catch (e) {
      emit(state.copyWith(getCustomerStatus: Status.error));
    }
  }

  void getAllProductUser(String userId) async {
    emit(state.copyWith(getAllProductsUserState: Status.loading));
    try {
      final productsUser = await _repo.getAllProductUser(userId);
      emit(state.copyWith(
        getAllProductsUserState: Status.success,
        productsUser: productsUser,
      ));
    } on FirebaseException catch (e) {
      emit(state.copyWith(
          getAllProductsUserState: Status.error, msg: e.message));
    }
  }

  void getAllProducts() async {
    emit(state.copyWith(getAllProductsStatus: Status.loading));
    try {
      final products = await _repo.getAllProducts();
      emit(state.copyWith(
          getAllProductsStatus: Status.success, products: products));
    } on FirebaseException catch (e) {
      emit(state.copyWith(getAllProductsStatus: Status.error, msg: e.message));
    }
  }

  Future<String> uploadMessageImage(
      String path,
      ) async {
    final value = await firebase_storage.FirebaseStorage.instance
        .ref()
        .child("messageImage/${Uri.file(path).pathSegments.last}")
        .putFile(File(path));
    return value.ref.getDownloadURL();

  }

 void  pickImageMessage({
    required ImageSource source,
  }) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
    );
    if (pickedFile != null) {
      emit(state.copyWith(imagePath: pickedFile.path));
      log(pickedFile.path);
    }
  }
 Future<void>  pickImage({
    required ImageSource source,
  }) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
    );
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      final image= base64Encode(bytes);
      emit(state.copyWith(imageMessagePath: image));
      log(pickedFile.path);
    }
  }
  changeImage(String image) {
    emit(state.copyWith(imageMessagePath: image));
  }

  String getImage(){
    return state.imageMessagePath;
  }

  void sendMessage({
    required String receiverId,
    required String text,
    required String dataTime,
    String? imageMessage,

  }) async {
    try{
      emit(state.copyWith(sendMessageStatus: Status.loading));

      MessageModel model = MessageModel(
        text: text,
        senderId: getId(),
        dataTime: dataTime,
        receiverId: receiverId,
        image: imageMessage != "" ? await uploadMessageImage(imageMessage!) : "",
      );

      CollectionReference senderChatCollection = FirebaseFirestore.instance
          .collection(AppConst.userCollection)
          .doc(getId())
          .collection(AppConst.chats)
          .doc(receiverId)
          .collection(AppConst.messages);

      CollectionReference receiverChatCollection = FirebaseFirestore.instance
          .collection(AppConst.customerCollection)
          .doc(receiverId)
          .collection(AppConst.chats)
          .doc(getId())
          .collection(AppConst.messages);
      await senderChatCollection.add(model.toMap());
      await receiverChatCollection.add(model.toMap());

      emit(state.copyWith(sendMessageStatus: Status.success,imagePath: ""));
    }catch (e){

      emit(state.copyWith(sendMessageStatus: Status.error,msg: e.toString()));

    }
  }
}
