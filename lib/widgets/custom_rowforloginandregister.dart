import 'package:flutter/material.dart';

class CustomRowForLoginAndRegister extends StatelessWidget {
  const CustomRowForLoginAndRegister({
    super.key,
    required this.text,
    required this.loginOrRegister,
    this.onTap,
  });

  final String text;
  final String loginOrRegister;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            loginOrRegister,
            style: const TextStyle(
              color: Color(0xffC7EDE6),
            ),
          ),
        ),
      ],
    );
  }
}
