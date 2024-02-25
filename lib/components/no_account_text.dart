import 'package:flutter/material.dart';

import '../../config/colors/colors.dart';
import '../features/user/screens/sign_in/sign_in_screen.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Sign in as User.. ",
          style: TextStyle(fontSize: 16, color: kTextColor[0]),
        ),
        GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignInScreenUser(),
            ),
          ),
          child: Text(
            "Sign in",
            style: TextStyle(
                fontSize: 16,
                color: kTextColor[0],
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
