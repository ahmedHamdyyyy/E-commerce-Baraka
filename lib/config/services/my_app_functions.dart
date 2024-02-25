import 'package:flutter/material.dart';
import 'package:shop/config/colors/colors.dart';
import 'package:shop/features/customer/logic/customer_cubit.dart';
import 'package:shop/features/customer/widgets/tost.dart';
import 'package:shop/features/user/logic/user_cubit.dart';

import '../../core/services/service_locator.dart';
import '../constants/constance.dart';
import '../widgets/subtitle_text.dart';
import '../widgets/title_text.dart';
import 'assets_manager.dart';

class MyAppFunctions {
  static Future<void> showErrorOrWarningDialog({
    required BuildContext context,
    required String subtitle,
    bool isError = true,
    required Function fct,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AssetsManager.warning,
                  height: 60,
                  width: 60,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SubtitleTextWidget(
                  label: subtitle,
                  color: kTextColor[0],
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.green, fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Future.delayed(
                          Duration(
                            milliseconds: 400,
                          ),
                          () {
                            getit<UserCubit>().logOut();
                            Navigator.pushNamedAndRemoveUntil(context,
                                AppConst.signInScreen, (route) => false);
                            showToast(
                                text: "Logout Successfully.",
                                State: ToastState.SUCCESS);
                          },
                        );
                        fct();
                      },
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  static Future<void> showDeleteCartgDialog({
    required BuildContext context,
    required String subtitle,
    bool isError = true,
    required CustomerState state,
    required Function fct,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0)),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  AssetsManager.warning,
                  height: 60,
                  width: 60,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                SubtitleTextWidget(
                  color: kTextColor[state.theme],
                  label: subtitle,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(color: Colors.green, fontSize: 18),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Future.delayed(
                          Duration(
                            milliseconds: 400,
                          ),
                          () {
                            getit<CustomerCubit>().clearCartFromFirebase();
                            Navigator.pop(context);
                            showToast(
                                text:
                                    "delete all products in cart successfully",
                                State: ToastState.SUCCESS);
                          },
                        );
                        fct();
                      },
                      child: const Text(
                        "OK",
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  static Future<void> imagePickerDialog({
    required BuildContext context,
    required Function cameraFCT,
    required Function galleryFCT,
    required Function removeFCT,
  }) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Center(
              child: TitlesTextWidget(
                label: "Choose option",
              ),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      cameraFCT();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("Camera"),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      galleryFCT();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.browse_gallery,
                    ),
                    label: const Text("Gallery"),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      removeFCT();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.remove_circle_outline,
                    ),
                    label: const Text("Remove"),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
