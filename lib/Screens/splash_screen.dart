import 'package:flutter/material.dart';
import 'package:machine_test/Screens/phonenumber_screen.dart';
import 'package:machine_test/widgets/custom_button_1.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/image.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 80,
              ),
              Image.asset(
                "assets/images/Frame.png",
                height: 50,
                width: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Connect.Meet.Love",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 31.46),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "With Fliq Dating",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 31.46),
              ),
              const Spacer(),
              const CustomButton1(
                imagePath: 'assets/images/Google.png',
                text: 'Sign in with Google',
                btnColor: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              const CustomButton1(
                imagePath: 'assets/images/fb.png',
                text: 'Sign in with Facebook',
                btnColor: Color(0xff3B5998),
                txtColor: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton1(
                imagePath: 'assets/images/Phone.png',
                text: 'Sign in with phone number',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PhoneNumberScreen(),
                      ));
                },
                btnColor: const Color(0xffE6446E),
                txtColor: Colors.white,
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .8,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    children: [
                      TextSpan(text: 'By signing up, you agree to our '),
                      TextSpan(
                        text: 'Terms',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: '. See how we use your data in our '),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: '.'),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
