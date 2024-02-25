import 'package:flutter/material.dart';

class Utils {
  static void errorDialog(BuildContext context, String error,
          {void Function()? onPressed}) =>
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(error),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('dismiss')),
                    TextButton(
                        onPressed: onPressed, child: const Text('Retry')),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  static void deleteDialog(BuildContext context, String error,
          {void Function()? onPressed}) =>
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  error,
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                          'لا',
                          style: TextStyle(fontSize: 20, color: Colors.green),
                        )),
                    TextButton(
                        onPressed: onPressed,
                        child: const Text(
                          'نعم',
                          style: TextStyle(fontSize: 20, color: Colors.red),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  static Future loadingDialog(BuildContext context) => showDialog(
        context: context,
        barrierDismissible: false,
        // ignore: deprecated_member_use
        builder: (context) => WillPopScope(
          onWillPop: () async => false,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Loading',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const Center(child: LinearProgressIndicator()),
                ],
              ),
            ),
          ),
        ),
      );

  static void successSnackBar(BuildContext context, String mes) =>
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(mes), backgroundColor: Colors.greenAccent));
}
