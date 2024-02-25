import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/config/constants/constance.dart';
import 'package:shop/features/customer/screens/home/all_products_screen.dart';
import '../../../core/services/service_locator.dart';
import '../logic/customer_cubit.dart';
import 'category_rounded_widget.dart';
import 'section_title.dart';

class ItemProducts extends StatefulWidget {
  const ItemProducts({super.key});

  @override
  State<ItemProducts> createState() => _ItemProductsState();
}

class _ItemProductsState extends State<ItemProducts> {
  String customerId = getit<CustomerCubit>().getId();

  @override
  void initState() {
    getit<CustomerCubit>().getCustomer(customerId);
    getit<CustomerCubit>().getAllProducts();
    getit<CustomerCubit>().getTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<CustomerCubit>(),
      child: BlocBuilder<CustomerCubit, CustomerState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SectionTitle(
                  color: Colors.cyan,
                  title: "Popular Products",
                  press: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              AllProductCustomerScreen(state: state),
                        ));
                  },
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3,
                children:
                    List.generate(AppConst.categoriesList.length, (index) {
                  return CategoryRoundedWidget(
                    state: state,
                    image: AppConst.categoriesList[index].image,
                    name: AppConst.categoriesList[index].name,
                  );
                }),
              ),
            ],
          );
        },
      ),
    );
  }
}
