import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'config/theme/them_app.dart';
import 'core/routes/app_route.dart';
import 'core/services/service_locator.dart';
import 'features/customer/logic/customer_cubit.dart';
import 'features/home/logic/cubit.dart';
import 'generated/l10n.dart';

class EcommerceApp extends StatelessWidget {
  const EcommerceApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => getit<HomeCubit>()..setApp(context),
      ),
      BlocProvider.value(
        value: getit<CustomerCubit>(),
      )
    ],
    child: BlocBuilder<CustomerCubit, CustomerState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Ecommerce',
          debugShowCheckedModeBanner: false,
          theme: Themes().theme(state.theme),
          onGenerateRoute: AppRoutes().appRoute,
          supportedLocales: S.delegate.supportedLocales,
          locale: const Locale('en'),
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    ),
  );
}