import 'package:flutter/material.dart';

class CustomButton1 extends StatelessWidget {
  const CustomButton1({
    super.key,
    required this.imagePath,
    required this.text,
    required this.btnColor,
    this.txtColor = Colors.black,
    this.onTap,
  });

  final String imagePath;
  final String text;
  final Color btnColor;
  final Color txtColor;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.sizeOf(context).width * .75,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: btnColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(imagePath),
            ),
            Text(
              text,
              style: TextStyle(color: txtColor),
            ),
          ],
        ),
      ),
    );
  }
}
