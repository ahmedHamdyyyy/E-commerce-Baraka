import '../../features/admin/data/data.dart';
import '../../features/admin/data/repository.dart';
import '../../features/admin/logic/cubit.dart';
import '../../features/customer/data/data.dart';
import '../../features/customer/data/repository.dart';
import '../../features/customer/logic/customer_cubit.dart';
import '../../features/home/data/data.dart';
import '../../features/home/data/repository.dart';
import '../../features/home/logic/cubit.dart';
import '../../features/user/data/data.dart';
import '../../features/user/data/repository.dart';
import '../../features/user/logic/user_cubit.dart';
import '../error/error_handler.dart';
import 'cache_services.dart';
import 'api_services.dart';

import 'package:get_it/get_it.dart';

final getit = GetIt.instance;

void setup() {
// services
  getit.registerSingleton<CacheServices>(CacheServices());
  getit.registerSingleton<ErrorHandler>(ErrorHandler());
  getit.registerSingleton<ApiServices>(ApiServices());
// data
  getit.registerSingleton<HomeData>(HomeData(getit<CacheServices>()));
  getit.registerLazySingleton<CustomerData>(
      () => CustomerData(getit<ApiServices>(), getit<CacheServices>()));
  getit.registerLazySingleton<UserData>(
      () => UserData(getit<ApiServices>(), getit<CacheServices>()));
  getit.registerLazySingleton<AdminData>(
      () => AdminData(getit<ApiServices>(), getit<CacheServices>()));
// repository
  getit.registerLazySingleton<CustomerRepository>(
      () => CustomerRepository(getit<CustomerData>(), getit<ErrorHandler>()));
  getit.registerLazySingleton<UserRepository>(
      () => UserRepository(getit<UserData>(), getit<ErrorHandler>()));
  getit.registerSingleton<HomeRepository>(
      HomeRepository(getit<HomeData>(), getit<ErrorHandler>()));
  getit.registerLazySingleton<AdminRepository>(
      () => AdminRepository(getit<AdminData>(), getit<ErrorHandler>()));
// cubit
  getit.registerLazySingleton<CustomerCubit>(
      () => CustomerCubit(getit<CustomerRepository>()));
  getit.registerSingleton<HomeCubit>(HomeCubit(getit<HomeRepository>()));
  getit.registerLazySingleton<UserCubit>(
      () => UserCubit(getit<UserRepository>()));
  getit.registerLazySingleton<AdminCubit>(
      () => AdminCubit(getit<AdminRepository>()));
}
