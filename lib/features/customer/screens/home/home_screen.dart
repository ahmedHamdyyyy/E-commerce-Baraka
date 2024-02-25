import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop/features/customer/screens/home/profile/profile_screen.dart';

import '../../../../config/colors/colors.dart';
import '../../../../core/services/service_locator.dart';
import '../../logic/customer_cubit.dart';
import 'AllOffers/all_offers_customer.dart';
import 'chat/all_of_users_screen_chats.dart';
import 'Favorite/favorite_screen.dart';

class HomeScreenCustomer extends StatefulWidget {
  const HomeScreenCustomer({super.key});

  @override
  State<HomeScreenCustomer> createState() => _HomeScreenCustomerState();
}

class _HomeScreenCustomerState extends State<HomeScreenCustomer> {
  int currentSelectedIndex = 0;

  void updateCurrentIndex(int index) {
    setState(() {
      currentSelectedIndex = index;
    });
  }

  final pages = [
    AllOffersCustomer(),
    const FavoriteScreen(),
    const AllUserScreenChats(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    getit<CustomerCubit>().getTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocProvider.value(
        value: getit<CustomerCubit>()..getTheme(),
        child: Scaffold(
          bottomNavigationBar: BlocBuilder<CustomerCubit, CustomerState>(
            builder: (context, state) {
              return BottomNavigationBar(
                onTap: updateCurrentIndex,
                currentIndex: currentSelectedIndex,
                /*    showSelectedLabels: false,
          showUnselectedLabels: false,*/
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/Shop Icon.svg",
                      colorFilter: ColorFilter.mode(
                        kTextColor[state.theme],
                        BlendMode.srcIn,
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/icons/Shop Icon.svg",
                      colorFilter: ColorFilter.mode(
                        foreGroundColor[1],
                        BlendMode.srcIn,
                      ),
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      color: kTextColor[state.theme],
                      "assets/icons/Heart Icon.svg",
                      colorFilter: ColorFilter.mode(
                        kTextColor[state.theme],
                        BlendMode.srcIn,
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/icons/Heart Icon.svg",
                      colorFilter: ColorFilter.mode(
                        foreGroundColor[1],
                        BlendMode.srcIn,
                      ),
                    ),
                    label: "Fav",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/Chat bubble Icon.svg",
                      colorFilter: ColorFilter.mode(
                        kTextColor[state.theme],
                        BlendMode.srcIn,
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/icons/Chat bubble Icon.svg",
                      colorFilter: ColorFilter.mode(
                        foreGroundColor[1],
                        BlendMode.srcIn,
                      ),
                    ),
                    label: "Chat",
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      "assets/icons/User Icon.svg",
                      colorFilter: ColorFilter.mode(
                        kTextColor[state.theme],
                        BlendMode.srcIn,
                      ),
                    ),
                    activeIcon: SvgPicture.asset(
                      "assets/icons/User Icon.svg",
                      colorFilter: ColorFilter.mode(
                        foreGroundColor[1],
                        BlendMode.srcIn,
                      ),
                    ),
                    label: "Fav",
                  ),
                ],
              );
            },
          ),
          body: pages[currentSelectedIndex],
        ),
      ),
    );
  }
}
