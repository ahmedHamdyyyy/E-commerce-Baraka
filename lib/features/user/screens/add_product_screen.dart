import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../../../components/custom_surfix_icon.dart';
import '../../../config/colors/colors.dart';
import '../../../config/constants/constance.dart';
import '../../../core/services/service_locator.dart';
import '../../../core/utils/utils.dart';
import '../../../core/validation/input_validation.dart';
import '../../../core/widget/elvated_button.dart';
import '../../../models/product.dart';
import '../logic/user_cubit.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();
  final categoryController = TextEditingController();
  final discountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> images = [];
  String? _categoryValue;


  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(
      value: getit<UserCubit>(),
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: checkOutCartColor[0],
          iconTheme: const IconThemeData(
            color: Colors.white
          ),

            ),
        body: Form(
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
                        hint: const Text("Choose a Category",
                          style: TextStyle(color: Colors.black),),
                        onChanged: (String? value) {
                          setState(() {
                            _categoryValue = value;
                          });
                        }),
                  ],
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(color: kTextColor[0]),
                  controller: descriptionController,
                  maxLines: 6,
                  minLines: 3,
                  validator: (value) => InputValidation.nameValidation(value),
                  decoration: const InputDecoration(
                    labelText: "description",
                    hintText: "Write a description of the product",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon:
                        CustomSuffixIcon(svgIcon: "assets/icons/User.svg"),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  style: TextStyle(color: kTextColor[0]),
                  keyboardType: TextInputType.name,
                  controller: nameController,
                  maxLength: 100,
                  validator: (value) => InputValidation.nameValidation(value),
                  decoration: const InputDecoration(
                    labelText: "Name Product",
                    hintText: "Enter your Name Product",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    suffixIcon:
                        CustomSuffixIcon(svgIcon: "assets/icons/Phone.svg"),
                  ),
                ),
             /*   TextFormField(
                  style: TextStyle(color: kTextColor[0]),
                  readOnly: true,
                  //initialValue: "123",
                  onTap: () {
                    showDialogCategory(context);
                  },
                  controller: TextEditingController(text: _selectedCategory),
                  decoration: const InputDecoration(
                    labelText: "Category",
                    hintText: "Please Enter Your Category",
                  ),
                ),*/
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(color: kTextColor[0]),
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
                            suffixIcon: Icon(Icons.price_change_outlined)),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextFormField(
                        style: TextStyle(color: kTextColor[0]),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'must not be empty';
                          }
                          return null;
                        },
                        controller: discountController,
                        keyboardType: TextInputType.phone,
                        maxLength: 8,
                        decoration: const InputDecoration(
                          labelText: "discount",
                          hintText: " Enter discount Product",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Icon(Icons.discount),
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: elevatedButtonTheme(),
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
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("add Photo", style: TextStyle(color: Colors.white)),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.photo_camera_back,
                        size: 35,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<UserCubit, UserState>(
                  listener: (context, state) {
                    if (state.addProductStatus == Status.success) {
                      Utils.successSnackBar(context, state.msg);
                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    return ElevatedButton(
                      style: elevatedButtonTheme(),
                      onPressed: () {
                        if(_formKey.currentState!.validate())return null;
                        getit<UserCubit>().addProduct(
                          ProductModel(
                            id: Uuid().v4(),
                            userId: getit<UserCubit>().getId(),
                            productName: nameController.text.trim(),
                            category:_categoryValue.toString() ,
                            desc: descriptionController.text.trim(),
                            productPrice: int.parse(priceController.text.trim()),
                            discount: int.parse(discountController.text.trim()),
                            folderId: AppConst.newId(),
                            images: images,

                          ),
                        );
                        nameController.clear();
                        categoryController.clear();
                        priceController.clear();
                        discountController.clear();
                        descriptionController.clear();
                      },
                      child: state.addProductStatus == Status.loading
                          ? const CircularProgressIndicator()
                          : const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "add Product",
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  size: 35,
                                  color: Colors.white,
                                  Icons.production_quantity_limits,
                                )
                              ],
                            ),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }


}
