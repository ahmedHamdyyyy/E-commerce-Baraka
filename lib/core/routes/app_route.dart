import 'package:flutter/material.dart';
import '../../config/constants/constance.dart';
import '../../features/admin/screens/home_screen.dart';
import '../../features/customer/screens/home/home_screen.dart';
import '../../features/home/screens/sign_in/sign_in_screen.dart';
import '../../features/home/screens/splash_screen.dart';
import '../../features/user/screens/add_product_screen.dart';
import '../../features/user/screens/dashboard_screen.dart';

class AppRoutes {
  Route<dynamic> appRoute(RouteSettings route) {
    if (route.name == AppConst.splashScreen) {
      return _route(const SplashScreen());
    }
    if (route.name == AppConst.adminScreen) {
      return _route(const AdminHomeScreen());
    }
    if (route.name == AppConst.userScreen) {
      return _route(const DashboardScreen());
    }
    if (route.name == AppConst.customerScreen) {
      return _route(const HomeScreenCustomer());
    }
    if (route.name == AppConst.addProductScreen) {
      return _route(const AddProductScreen());
    }
    if (route.name == AppConst.signInScreen) {
      return _route(const SignInScreen());
    }
    return _wrongRoute();
  }

  Route _route(Widget page) => MaterialPageRoute(builder: (context) => page);
  Route _wrongRoute() =>
      _route(Scaffold(appBar: AppBar(title: const Text('wrong route'))));
}
