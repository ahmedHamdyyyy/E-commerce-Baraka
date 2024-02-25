import 'core/services/api_services.dart';
import 'core/services/cache_services.dart';
import 'core/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'ecommerce_app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setup();
  await getit<CacheServices>().init();
  await getit<ApiServices>().init();

  runApp(const EcommerceApp());
}


