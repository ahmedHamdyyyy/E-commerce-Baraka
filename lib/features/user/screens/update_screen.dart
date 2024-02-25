import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/features/user/widgets/Loding.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../config/constants/constance.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/validation/input_validation.dart';
import '../../../models/product.dart';
import '../logic/user_cubit.dart';

// ignore: must_be_immutable
class UpdateScreen extends StatefulWidget {
  UpdateScreen({super.key, required this.id});
  String id;
  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  @override
  void initState() {
    super.initState();
    getit<UserCubit>().getProduct(widget.id);
  }

  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final discountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? value;
  List<String> images = [];
  String? _categoryValue;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<UserCubit>(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          descriptionController.text = state.product.desc;
          discountController.text = state.product.discount.toString();
          _categoryValue = state.product.category;
          nameController.text = state.product.productName;
          priceController.text = state.product.productPrice.toString();
          return Scaffold(
            appBar: AppBar(
              actions: [
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    return TextButton(
                      onPressed: () {
                        getit<UserCubit>().updateProduct(
                          ProductModel(
                            id: state.product.id,
                            userId: getit<UserCubit>().getId(),
                            productName: nameController.text.trim(),
                            category: _categoryValue!,
                            desc: descriptionController.text.trim(),
                            productPrice: int.parse(priceController.text.trim()),
                            discount: int.parse(discountController.text.trim()),
                            folderId: state.product.folderId,
                            images: state.product.images,
                          ),
                        );
                        //nameController.clear();
                      },
                      child: state.updateProductStatus == Status.loading
                          ? const CircularProgressIndicator()
                          : const Text(
                              "update Product",
                              //style: TextStyle(color: Colors.white),
                            ),
                    );
                  },
                ),
              ],
            ),
            body: state.getProductStatus==Status.loading?Loading(): body_update_product(state),
          );
        },
      ),
    );
  }
  RefreshIndicator body_update_product(UserState state) {
    return RefreshIndicator(
      onRefresh: () async => getit<UserCubit>().getProduct(widget.id),
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ListView(
            children: [

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButton(
                      items: AppConst.categoriesDropDownList,
                      value: _categoryValue,
                      hint:  Text( _categoryValue!,
                        style: TextStyle(color: Colors.black),),
                      onChanged: (String? value) {
                        setState(() {
                          _categoryValue =  value;
                        });
                      }),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                controller: descriptionController,
                maxLines: 6,
                minLines: 3,
                validator: (value) =>
                    InputValidation.nameValidation(value),
                decoration: const InputDecoration(
                  labelText: "description",
                  hintText: "Write a description of the product",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: CustomSuffixIcon(
                      svgIcon: "assets/icons/User.svg"),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.name,
                controller: nameController,
                style: const TextStyle(color: Colors.black),
                maxLength: 40,
                validator: (value) =>
                    InputValidation.nameValidation(value),
                decoration: const InputDecoration(
                  labelText: "Name Product",
                  hintText: "Enter your Name Product",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: CustomSuffixIcon(
                      svgIcon: "assets/icons/Phone.svg"),
                ),
              ),
              /*    TextFormField(
                      validator: (value) =>
                          InputValidation.nameValidation(value),
                      controller: categoryController,
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                        labelText: "category",
                        hintText: "Please Enter your category",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                    ),*/
              const SizedBox(height: 20),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'must not be empty';
                  }
                  return null;
                },
                controller: priceController,
                keyboardType: TextInputType.number,
                maxLength: 8,
                decoration: const InputDecoration(
                  labelText: "price",
                  hintText: "Please Enter Price Product",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: CustomSuffixIcon(
                      svgIcon: "assets/icons/Location point.svg"),
                ),
              ),
              TextFormField(
                validator: (value) =>
                    InputValidation.nameValidation(value),
                controller: discountController,
                style: const TextStyle(color: Colors.black),
                keyboardType: TextInputType.phone,
                maxLength: 8,
                decoration: const InputDecoration(
                  labelText: "discount",
                  hintText: " Enter discount Product",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: CustomSuffixIcon(
                      svgIcon: "assets/icons/Location point.svg"),
                ),
              ),
              ElevatedButton(
                onPressed: ()  {
                  getit<UserCubit>().updateProduct(
                    ProductModel(
                      id: state.product.id,
                      userId: getit<UserCubit>().getId(),
                      productName: nameController.text.trim(),
                      category: _categoryValue!,
                      desc: descriptionController.text.trim(),
                      productPrice: int.parse(priceController.text.trim()),
                      discount: int.parse(discountController.text.trim()),
                      folderId: state.product.folderId,
                      images: state.product.images,
                    ),
                  );
                },
                child: state.updateProductStatus == Status.loading
                    ? const CircularProgressIndicator()
                    : Text("Update Product"),
              ),

              /* ElevatedButton(
                      onPressed: () async {
                        {
                          final result = await FilePicker.platform
                              .pickFiles(allowMultiple: true);
                          if (result == null || result.files.isEmpty) return;

                          for (PlatformFile file in result.files) {
                            if (file.path != null) images.add(file.path!);
                          }
                        }
                      },
                      child: const Text("add Photo"),
                    ),*/
            ],
          ),
        ),
      ),
    );
  }

}
