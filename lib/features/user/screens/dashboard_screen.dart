// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../../config/services/assets_manager.dart';
import '../../../config/widgets/dashboard_btns.dart';
import '../../../config/widgets/title_text.dart';
import '../models/dashboard_btn_model.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: const TitlesTextWidget(label: "Dashboard Screen"),
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(AssetsManager.shoppingCart),
            ),
          ),
          body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(
              DashboardButtonsModel.dashboardBtnList(context).length,
              (index) => DashboardButtonsWidget(
                text:
                    DashboardButtonsModel.dashboardBtnList(context)[index].text,
                imagePath:
                    DashboardButtonsModel.dashboardBtnList(context)[index]
                        .imagePath,
                onPressed:
                    DashboardButtonsModel.dashboardBtnList(context)[index]
                        .onPressed,
              ),
            ),
          )),
    );
  }
}
